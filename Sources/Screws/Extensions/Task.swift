@available(watchOS 6.0, *)
@available(iOS 13.0, *)
@available(tvOS 13.0, *)
@available(macOS 10.15, *)
extension Task where Success == Never, Failure == Never {
    /// Sleeps a task for a specified amount of seconds
    /// - Parameters:
    ///   - seconds: The amount of seconds to sleep.
    ///   - Throws: If the task is canceled before the time ends, this function throws `CancellationError`.
    public static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}

@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(tvOS 16.0, *)
@available(watchOS 9.0, *)
@available(visionOS 1.0, *)
/// Errors emitted by `Task` timeout helpers.
public enum TaskTimeoutError: Error {
    /// The task exceeded the provided timeout duration.
    case timeout(Duration)
}

@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(tvOS 16.0, *)
@available(watchOS 9.0, *)
@available(visionOS 1.0, *)
public extension Task where Failure == Error {
    /// Start a new Task with a timeout. If the timeout expires before the operation is
    /// completed then the task is cancelled and an error is thrown.
    init(priority: TaskPriority? = nil,
         timeout: Duration,
         operation: @escaping @Sendable () async throws -> Success) {
        self = Task(priority: priority) {
            try await withThrowingTaskGroup(of: Success.self) { group -> Success in
                group.addTask(operation: operation)
                group.addTask {
                    try await _Concurrency.Task.sleep(for: timeout)
                    throw TaskTimeoutError.timeout(timeout)
                }
                guard let success = try await group.next() else {
                    throw _Concurrency.CancellationError()
                }
                group.cancelAll()
                return success
            }
        }
    }

    /// Convenience helper that creates a task with a default priority and timeout.
    /// - Parameters:
    ///   - duration: The maximum duration before the task is canceled. Defaults to 10 seconds.
    ///   - operation: The async operation to execute.
    /// - Returns: A task that either completes or throws `TaskTimeoutError`.
    static func withTimeout(duration: Duration = .seconds(10), operation: @escaping @Sendable () async throws -> Success) -> Task {
        Task(priority: .userInitiated, timeout: duration, operation: operation)
    }

    /// Runs the operation and awaits its result, throwing if the timeout expires.
    /// - Parameters:
    ///   - duration: The maximum duration before the task is canceled. Defaults to 10 seconds.
    ///   - operation: The async operation to execute.
    /// - Returns: The result of the operation if it completes before the timeout.
    static func withTimeout(duration: Duration = .seconds(10),
                            operation: @escaping @Sendable () async throws -> Success) async throws -> Success {
        try await Task.withTimeout(duration: duration, operation: operation).value
    }
}

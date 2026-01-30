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
public enum TaskTimeoutError: Error {
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

    static func withTimeout(duration: Duration = .seconds(10), operation: @escaping @Sendable () async throws -> Success) -> Task {
        Task(priority: .userInitiated, timeout: duration, operation: operation)
    }
}

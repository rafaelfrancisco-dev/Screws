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

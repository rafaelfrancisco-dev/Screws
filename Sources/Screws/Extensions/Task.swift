@available(watchOS 6.0, *)
@available(iOS 13.0, *)
@available(tvOS 13.0, *)
@available(macOS 10.15, *)
extension Task where Success == Never, Failure == Never {
    public static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}

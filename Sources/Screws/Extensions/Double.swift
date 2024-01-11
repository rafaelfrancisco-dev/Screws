import Foundation

extension Double {
    /// Format a double with decimal places
    /// - Parameters:
    ///     - f: Decimal places to format
    ///  - Returns:
    ///     The formatted double as a String.
    public func format(f: Double) -> String {
        String(format: "%\(f.description)f", self)
    }
}

import Foundation

extension Double {
    /// Format a double with decimal places using String.format.
    /// - Parameters:
    ///     - f: Decimal places to format
    ///  - Returns:
    ///     The formatted double as a String.
    public func format(f: Double) -> String {
        String(format: "%\(f.description)f", self)
    }
    
    /// Format a double with a specifc number of places.
    /// - Parameters:
    ///     - f: Decimal places to format
    ///  - Returns:
    ///     The rounded double.
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

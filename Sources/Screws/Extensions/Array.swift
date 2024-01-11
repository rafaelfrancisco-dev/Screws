import Foundation

extension Array {
    /// Chunks an array into several equal sized chunks (save for the last one if that isn't possible)
    ///- Parameters:
    ///   - size: The number of elements in each chunk.
    /// - Returns:
    ///  The array of chunks.
    public func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    /// Return the differnce between two arrays
    ///- Parameters:
    ///     - other: The array to compare to.
    /// - Returns:
    ///  An array with the different elements.
    public func difference(from other: [Element]) -> [Element] where Element: Hashable {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

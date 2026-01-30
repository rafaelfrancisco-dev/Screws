//
//  SkipEncode.swift
//  Screws
//
//  Created by Rafael Francisco on 10/02/2025.
//

import Foundation

/// A property wrapper that skips encoding while still supporting decoding.
@propertyWrapper
public struct SkipEncode<T: Sendable>: Sendable {
   /// The wrapped value.
   public var wrappedValue: T
    
    /// Creates a wrapper around the given value.
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}

extension SkipEncode: Decodable where T: Decodable {
    /// Decodes the wrapped value from a single value container.
    public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      self.wrappedValue = try container.decode(T.self)
   }
}

extension SkipEncode: Encodable {
    /// Encodes nothing, effectively skipping the wrapped value.
    public func encode(to encoder: Encoder) throws {
      // nothing to do here
   }
}

extension KeyedEncodingContainer {
    /// Encodes nothing for `SkipEncode` values, preserving key presence.
    public mutating func encode<T>(_ value: SkipEncode<T>, forKey key: K) throws {
      // overload, but do nothing
   }
}

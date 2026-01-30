//
//  FloatingPoint.swift
//
//
//  Created by Rafael Francisco on 04/03/2024.
//

import Foundation

extension BinaryFloatingPoint {
    /// Return integer part of number.
    /// - Returns:
    ///     The int part of the number.
    public var whole: Int { Int(self.rounded(.towardZero)) }
    
    /// Return fractional part of number.
    /// - Returns:
    ///     The fractional part of the number.
    public var fraction: Self { self - self.rounded(.towardZero) }
}

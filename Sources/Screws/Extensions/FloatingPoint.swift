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
    var whole: Int { Int(modf(self).0) }
    
    /// Return fractional part of number.
    /// - Returns:
    ///     The fractional part of the number.
    var fraction: Self { modf(self).1 }
}

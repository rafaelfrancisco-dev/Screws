//
//  File.swift
//  
//
//  Created by Rafael Francisco on 10/01/2024.
//

import Foundation

extension Double {
    public func format(f: Double) -> String {
        String(format: "%\(f.description)f", self)
    }
}

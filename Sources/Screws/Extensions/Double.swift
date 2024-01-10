//
//  File.swift
//  
//
//  Created by Rafael Francisco on 10/01/2024.
//

import Foundation

extension Double {
    func format(f: String) -> String {
        String(format: "%\(f)f", self)
    }
}

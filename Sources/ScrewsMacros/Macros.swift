//
//  Macros.swift
//  Screws
//
//  Created by Rafael Francisco on 06/02/2025.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct ScrewsMacros: CompilerPlugin {
  // Here we explicitly register macros.
  var providingMacros: [Macro.Type] = [
    DTOGeneratorMacro.self
  ]
}

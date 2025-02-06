//
//  DTOGenerator.swift
//  Screws
//
//  Created by Rafael Francisco on 06/02/2025.
//

@attached(peer)
public macro GenerateDTO(codable: Bool = false) = #externalMacro(module: "ScrewsMacros", type: "DTOGeneratorMacro")

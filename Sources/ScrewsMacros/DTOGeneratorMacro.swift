//
//  DTOGeneratorMacro.swift
//  Screws
//
//  Created by Rafael Francisco on 06/02/2025.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct DTOGeneratorMacro: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let classDecl = declaration.as(ClassDeclSyntax.self) else {
            throw CustomError.notAClass
        }
        
        let codable = node.arguments?.as(LabeledExprListSyntax.self)?.first { arg in
            arg.label?.text == "codable"
        }?.expression.as(BooleanLiteralExprSyntax.self)?.literal.text == "true"
        
        let className = classDecl.name.text
        let dtoName = "\(className)DTO"
        
        // Collect properties and initializer parameters
        var properties: [(name: String, type: String)] = []
        var initializerParams: [(label: String, name: String, type: String)] = []
        
        for member in classDecl.memberBlock.members {
            if let varDecl = member.decl.as(VariableDeclSyntax.self),
               let binding = varDecl.bindings.first,
               let type = binding.typeAnnotation?.type,
               let pat = binding.pattern.as(IdentifierPatternSyntax.self) {
                properties.append((name: pat.identifier.text, type: type.description))
            } else if let initDecl = member.decl.as(InitializerDeclSyntax.self) {
                for param in initDecl.signature.parameterClause.parameters {
                    let label = param.firstName.text
                    let name = param.secondName?.text ?? label
                    let type = param.type.description
                    initializerParams.append((label: label, name: name, type: type))
                }
            }
        }
        
        var conformances = ["Sendable"]
        if codable {
            conformances.append("Codable")
        }
        let conformanceList = conformances.joined(separator: ", ")
        
        let structDecl = try StructDeclSyntax("struct \(raw: dtoName): \(raw: conformanceList)") {
            // Properties
            for prop in properties {
                DeclSyntax("let \(raw: prop.name): \(raw: prop.type)")
            }
            
            // Direct constructor if we found an initializer
            if !initializerParams.isEmpty {
                try InitializerDeclSyntax("""
                    init(\(raw: initializerParams.map { "\($0.label) \($0.name): \($0.type)" }.joined(separator: ", ")))
                    """) {
                    for param in initializerParams {
                        ExprSyntax("self.\(raw: param.label) = \(raw: param.name)")
                    }
                }
            }
            
            // From source constructor
            try InitializerDeclSyntax("init(from source: \(raw: className))") {
                for prop in properties {
                    ExprSyntax("self.\(raw: prop.name) = source.\(raw: prop.name)")
                }
            }
            
            // Copy to method
            try FunctionDeclSyntax("func copyTo(_ target: \(raw: className))") {
                for prop in properties {
                    ExprSyntax("target.\(raw: prop.name) = self.\(raw: prop.name)")
                }
            }
            
            if codable {
                try InitializerDeclSyntax("init(from decoder: Decoder) throws") {
                    ExprSyntax("let container = try decoder.container(keyedBy: CodingKeys.self)")
                    for prop in properties {
                        ExprSyntax("self.\(raw: prop.name) = try container.decode(\(raw: prop.type).self, forKey: .\(raw: prop.name))")
                    }
                }
                
                try EnumDeclSyntax("private enum CodingKeys: String, CodingKey") {
                    for prop in properties {
                        DeclSyntax("case \(raw: prop.name)")
                    }
                }
            }
        }
        
        return [DeclSyntax(structDecl)]
    }
}

enum CustomError: Error, CustomStringConvertible {
    case notAClass
    
    var description: String {
        switch self {
        case .notAClass:
            return "@GenerateDTO can only be applied to classes"
        }
    }
}

//
//  File.swift
//  Screws
//
//  Created by Rafael Francisco on 06/02/2025.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
@testable import Screws
@testable import ScrewsMacros

final class DTOGeneratorTests: XCTestCase {
    let testMacros: [String: Macro.Type] = [
        "GenerateDTO": DTOGeneratorMacro.self
    ]
    
    func testBasicDTO() throws {
        assertMacroExpansion(
            """
            @GenerateDTO
            class User {
                var id: Int
                var name: String
            }
            """,
            expandedSource: """
            class User {
                var id: Int
                var name: String
            }
            
            struct UserDTO: Sendable {
                let id: Int
                let name: String
                init(from source: User) {
                    self.id = source.id
                    self.name = source.name
                }
                func copyTo(_ target: User) {
                    target.id = self.id
                    target.name = self.name
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testCodableDTO() throws {
        assertMacroExpansion(
            """
            @GenerateDTO(codable: true)
            class User {
                var id: Int
                var name: String
            }
            """,
            expandedSource: """
            class User {
                var id: Int
                var name: String
            }

            struct UserDTO: Sendable, Codable {
                let id: Int
                let name: String
                init(from source: User) {
                    self.id = source.id
                    self.name = source.name
                }
                func copyTo(_ target: User) {
                    target.id = self.id
                    target.name = self.name
                }
                init(from decoder: Decoder) throws {let container = try decoder.container(keyedBy: CodingKeys.self)
                    self.id = try container.decode(Int.self, forKey: .id)
                    self.name = try container.decode(String.self, forKey: .name)
                }
                private enum CodingKeys: String, CodingKey {
                    case id
                    case name
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testComplexTypes() throws {
        assertMacroExpansion(
            """
            @GenerateDTO
            class Account {
                var createdAt: Date
                var settings: [String: Bool]
                var tags: Set<String>
            }
            """,
            expandedSource: """
            class Account {
                var createdAt: Date
                var settings: [String: Bool]
                var tags: Set<String>
            }
            
            struct AccountDTO: Sendable {
                let createdAt: Date
                let settings: [String: Bool]
                let tags: Set<String>
                init(from source: Account) {
                    self.createdAt = source.createdAt
                    self.settings = source.settings
                    self.tags = source.tags
                }
                func copyTo(_ target: Account) {
                    target.createdAt = self.createdAt
                    target.settings = self.settings
                    target.tags = self.tags
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testNonClassError() throws {
        assertMacroExpansion(
            """
            @GenerateDTO
            struct Invalid {}
            """,
            expandedSource: """
            struct Invalid {}
            """,
            diagnostics: [
                DiagnosticSpec(message: "@GenerateDTO can only be applied to classes", line: 1, column: 1)
            ],
            macros: testMacros
        )
    }
}

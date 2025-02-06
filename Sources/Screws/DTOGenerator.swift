//
//  DTOGenerator.swift
//  Screws
//
//  Created by Rafael Francisco on 06/02/2025.
//

/// A macro that automatically generates a Data Transfer Object (DTO) from a class definition.
///
/// The `GenerateDTO` macro creates a corresponding DTO structure that mirrors the properties
/// of the annotated class. The generated DTO includes initialization from the source class,
/// methods to copy data back to the source, and optional `Codable` conformance.
///
/// Use this macro to reduce boilerplate when implementing the DTO pattern in your codebase.
/// The generated DTO structure is always `Sendable` and can optionally conform to `Codable`
/// through the `codable` parameter.
///
/// ```swift
/// @GenerateDTO(codable: true)
/// class User {
///     var name: String
///     var age: Int
///     var email: String
/// }
/// ```
///
/// This generates a `UserDTO` structure with the following features:
/// - All properties from the `User` class
/// - Initialization from a `User` instance
/// - A method to copy data back to a `User` instance
/// - `Codable` conformance for serialization
///
/// You can then use the generated DTO like this:
///
/// ```swift
/// let user = User()
/// user.name = "John Doe"
/// user.age = 30
/// user.email = "john@example.com"
///
/// // Create DTO from user
/// let dto = UserDTO(from: user)
///
/// // Transfer data back to a user instance
/// let newUser = User()
/// dto.copyTo(newUser)
/// ```
///
/// - Parameters:
///   - codable: A boolean value that determines whether the generated DTO should conform
///     to the `Codable` protocol. When `true`, the DTO will include the necessary coding
///     keys and coding methods. Defaults to `false`.
///
/// - Important: This macro can only be applied to class declarations. Attempting to use it
///   with structures or other types will result in a compilation error.
///
/// - Note: The generated DTO is always `Sendable` regardless of the `codable` parameter value,
///   making it safe to transfer across concurrency boundaries.
@attached(peer, names: suffixed(DTO))
public macro GenerateDTO(codable: Bool = false) = #externalMacro(module: "ScrewsMacros", type: "DTOGeneratorMacro")

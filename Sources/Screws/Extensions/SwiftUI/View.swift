//
//  View.swift
//
//
//  Created by Rafael Francisco on 01/03/2024.
//

import SwiftUI

@available(watchOS 6.0, *)
@available(iOS 13.0, *)
@available(tvOS 13.0, *)
@available(macOS 10.15, *)
@available(visionOS 1.0, *)
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder public func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    public func centerContentsHorizontally() -> some View {
        modifier(CenterModifierHorizontal())
    }
    
    public func centerContentsVertical() -> some View {
        modifier(CenterModifierVertical())
    }
}

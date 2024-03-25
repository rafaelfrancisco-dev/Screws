//
//  CenterModifier.swift
//
//
//  Created by Rafael Francisco on 25/03/2024.
//

import SwiftUI

@available(watchOS 6.0, *)
@available(iOS 13.0, *)
@available(tvOS 13.0, *)
@available(macOS 10.15, *)
@available(visionOS 1.0, *)
struct CenterModifierHorizontal: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
} 

@available(watchOS 6.0, *)
@available(iOS 13.0, *)
@available(tvOS 13.0, *)
@available(macOS 10.15, *)
@available(visionOS 1.0, *)
struct CenterModifierVertical: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            content
            Spacer()
        }
    }
}

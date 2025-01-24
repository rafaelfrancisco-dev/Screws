//
//  View.swift
//
//
//  Created by Rafael Francisco on 01/03/2024.
//

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS) || os(visionOS)
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
    
    /// Centers the view's contents horizontally within its bounds.
    /// - Returns: A view with horizontally centered contents using the CenterModifierHorizontal.
    public func centerContentsHorizontally() -> some View {
        modifier(CenterModifierHorizontal())
    }
    
    /// Centers the view's contents vertically within its bounds.
    /// - Returns: A view with vertically centered contents using the CenterModifierVertical.
    public func centerContentsVertical() -> some View {
        modifier(CenterModifierVertical())
    }
    
    /// Tracks the size of the view and binds it to the provided size parameter.
    /// - Parameter size: A binding to store the view's current CGSize.
    /// - Returns: A view that updates the bound size parameter whenever its frame changes.
    @available(iOS 17.0, *)
    @available(macOS 14.0, *)
    @available(watchOS 10.0, *)
    @available(tvOS 17.0, *)
    @available(visionOS 1.0, *)
    public func frameTracker(size: Binding<CGSize>) -> some View {
        modifier(FrameTracker(size: size))
    }
}
#endif

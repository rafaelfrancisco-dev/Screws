//
//  SwiftUIView.swift
//  Screws
//
//  Created by Rafael Francisco on 24/01/2025.
//

import SwiftUI

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS) || os(visionOS)
/// A view modifier that tracks and updates the size of a view.
/// - Note: Uses GeometryReader to measure the view's dimensions and updates the bound size parameter when changes occur.
@available(watchOS 10.0, *)
@available(iOS 17.0, *)
@available(macOS 14.0, *)
@available(tvOS 17.0, *)
@available(visionOS 1.0, *)
struct FrameTracker: ViewModifier {
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        size = proxy.size
                    }
                    .onChange(of: proxy.size) { oldSize, newSize in
                        size = newSize
                    }
            }
        )
    }
}

@available(iOS 17.0, *)
@available(macOS 14.0, *)
@available(watchOS 10.0, *)
@available(tvOS 17.0, *)
@available(visionOS 1.0, *)
#Preview {
    Text("Inside Frame tracker")
        .frameTracker(size: .constant(.zero))
}
#endif

//
//  Convenience.swift
//
//
//  Created by Rafael Francisco on 25/03/2024.
//

#if os(watchOS)
import WatchKit
#elseif os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

@MainActor
/// Cross-platform convenience metrics for the current device.
public class Convenience {
#if os(watchOS)
    /// Screen width in points for the current watch device.
    public static let deviceWidth:CGFloat = WKInterfaceDevice.current().screenBounds.size.width
    /// Screen height in points for the current watch device.
    public static let deviceHeight:CGFloat = WKInterfaceDevice.current().screenBounds.size.height
#elseif os(iOS)
    /// Screen width in points for the current iOS device.
    public static let deviceWidth:CGFloat = UIScreen.main.bounds.size.width
    /// Screen height in points for the current iOS device.
    public static let deviceHeight:CGFloat = UIScreen.main.bounds.size.height
#elseif os(macOS)
    /// Screen width in points for the main display (if available).
    public static let deviceWidth:CGFloat? = NSScreen.main?.visibleFrame.size.width
    /// Screen height in points for the main display (if available).
    public static let deviceHeight:CGFloat? = NSScreen.main?.visibleFrame.size.height
#endif
}

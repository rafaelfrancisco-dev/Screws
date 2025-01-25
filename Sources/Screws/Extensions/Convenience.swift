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
public class Convenience {
#if os(watchOS)
    public static let deviceWidth:CGFloat = WKInterfaceDevice.current().screenBounds.size.width
    public static let deviceHeight:CGFloat = WKInterfaceDevice.current().screenBounds.size.height
#elseif os(iOS)
    public static let deviceWidth:CGFloat = UIScreen.main.bounds.size.width
    public static let deviceHeight:CGFloat = UIScreen.main.bounds.size.height
#elseif os(macOS)
    public static let deviceWidth:CGFloat? = NSScreen.main?.visibleFrame.size.width
    public static let deviceHeight:CGFloat? = NSScreen.main?.visibleFrame.size.height
#endif
}

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

public class Convenience{
#if os(watchOS)
    public static var deviceWidth:CGFloat = WKInterfaceDevice.current().screenBounds.size.width
    public static var deviceHeight:CGFloat = WKInterfaceDevice.current().screenBounds.size.height
#elseif os(iOS)
    public static var deviceWidth:CGFloat = UIScreen.main.bounds.size.width
    public static var deviceHeight:CGFloat = UIScreen.main.bounds.size.height
#elseif os(macOS)
    public static var deviceWidth:CGFloat? = NSScreen.main?.visibleFrame.size.width
    public static var deviceHeight:CGFloat? = NSScreen.main?.visibleFrame.size.height
#endif
}

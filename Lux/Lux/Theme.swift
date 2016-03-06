//
//  Theme.swift
//  Lux
//
//  Created by James Pickering on 2/4/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

struct Theme {
    static func whiteColor() -> NSColor {
        return Theme.whiteColor(1.0)
    }
    
    static func whiteColor(opacity: CGFloat) -> NSColor {
        return NSColor(calibratedRed: 1.0, green: 254/255.0, blue: 248/255.0, alpha: opacity)
    }
    
    static func buttonBackgroundColor() -> NSColor {
        return NSColor(calibratedRed: 235/255.0, green: 234/255.0, blue: 228/255.0, alpha: 1.0)
    }
    
    static func buttonSelectedBackgroundColor() -> NSColor {
        return NSColor(calibratedRed: 225/255.0, green: 224/255.0, blue: 218/255.0, alpha: 1.0)
    }
    
    static func clearColor() -> NSColor {
        return NSColor.clearColor()
    }
    
    static func unfocusedColor() -> NSColor {
        return Theme.brownColor(0.3)
    }
    
    static func brownColor() -> NSColor {
        return Theme.brownColor(1.0)
    }
    
    static func brownColor(opacity: CGFloat) -> NSColor {
        return NSColor(calibratedRed: 51/255.0, green: 40/255.0, blue: 29/255.0, alpha: opacity)
    }
    
    static func dividerColor() -> NSColor {
        return NSColor(calibratedRed: 51/255.0, green: 40/255.0, blue: 29/255.0, alpha: 0.3)
    }
    
    static func greenColor() -> NSColor {
        return Theme.greenColor(1.0)
    }
    
    static func greenColor(opacity: CGFloat) -> NSColor {
        return NSColor(calibratedRed: 92/255.0, green: 153/255.0, blue: 153/255.0, alpha: opacity)
    }
    
    static func yellowColor() -> NSColor {
        return Theme.yellowColor(1.0)
    }
    
    static func yellowColor(opacity: CGFloat) -> NSColor {
        return NSColor(calibratedRed: 242/255.0, green: 207/255.0, blue: 113/255.0, alpha: opacity)
    }
    
    static func highlightColor() ->  NSColor {
        return NSColor(calibratedRed: 122/255.0, green: 183/255.0, blue: 193/255.0, alpha: 0.6)
    }
    
    static func font(size: CGFloat) -> NSFont {
        return NSFont(name: "Neue Haas Unica Pro", size: size)!
    }
    
    static func mediumFont(size: CGFloat) -> NSFont {
        return NSFont(name: "Neue Haas Unica Pro Medium", size: size)!
    }
    
    static func boldFont(size: CGFloat) -> NSFont {
        return NSFont(name: "Neue Haas Unica Pro Bold", size: size)!
    }
}

extension NSImage {
    func tinted(color: NSColor) -> NSImage {
        let bounds = NSMakeRect(0, 0, size.width, size.height)
        let image = self.copy() as! NSImage
        
        image.lockFocus()
        color.set()
        NSRectFillUsingOperation(bounds, .CompositeSourceAtop)
        image.unlockFocus()
        
        return image
    }
}

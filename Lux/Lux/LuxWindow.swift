//
//  LuxWindow.swift
//  Lux
//
//  Created by James Pickering on 2/7/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

class LuxWindow: NSWindow {
    
    override init(contentRect: NSRect, styleMask aStyle: Int, backing bufferingType: NSBackingStoreType, `defer` flag: Bool) {
        super.init(contentRect: contentRect, styleMask: aStyle, backing: bufferingType, `defer`: flag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var canBecomeKeyWindow: Bool {
        return true
    }
}

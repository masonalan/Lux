//
//  AppDelegate.swift
//  Lux
//
//  Created by James Pickering on 2/4/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let windowController = LuxWindowController()
        windowController.showWindow(nil)
        Lux.setWindowController(windowController)
    }
}

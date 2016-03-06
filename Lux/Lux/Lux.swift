//
//  Lux.swift
//  Lux
//
//  Created by James Pickering on 2/9/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

struct Lux {
    private static var _windowController: LuxWindowController?
    static func windowController() -> LuxWindowController? {
        return _windowController
    }
    static func setWindowController(windowController: LuxWindowController) {
        _windowController = windowController
    }
}
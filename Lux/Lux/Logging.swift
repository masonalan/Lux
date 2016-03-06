//
//  Logging.swift
//  Lux
//
//  Created by James Pickering on 2/7/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

/**
 Equivalent of "print(items: Any...)"
 Use instead because NSView implements a different "print" function for some stupid reason
 
 - parameter items: items to print
 */
func console(items: Any...) {
    print(items)
}
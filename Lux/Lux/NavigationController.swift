//
//  NavigationController.swift
//  Lux
//
//  Created by James Pickering on 2/4/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

private class TitleView: NSView {
    weak var titleLabel: NSTextField!
    weak var downArrow: NSButton!
    var title: String? {
        didSet {
            titleLabel.stringValue = title!
        }
    }
    
    init() {
        super.init(frame: NSMakeRect(0, 0, 0, 0))
        
        let titleLabel = NSTextField(frame: NSMakeRect(0, 0, 0, 0))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = Theme.brownColor()
        titleLabel.font = Theme.font(13)
        titleLabel.stringValue = "4.33 - 53"
        titleLabel.editable = false
        titleLabel.selectable = false
        titleLabel.bordered = false
        addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let downArrow = NSButton(frame: NSMakeRect(0, 0, 7, 3.5))
        downArrow.translatesAutoresizingMaskIntoConstraints = false
        downArrow.image = NSImage(named: "Down")
        downArrow.imagePosition = .ImageOnly
        downArrow.bordered = false
        (downArrow.cell as! NSButtonCell).imageScaling = .ScaleProportionallyDown
        addSubview(downArrow)
        self.downArrow = downArrow
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[title]-4-[downArrow(==7)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["title": titleLabel, "downArrow": downArrow]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(-1)-[title]-(1)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["title": titleLabel, "downArrow": downArrow]))
        addConstraint(NSLayoutConstraint(item: downArrow, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 5.0))
        addConstraint(NSLayoutConstraint(item: downArrow, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class NavigationView: NSView {
    weak var closeButton: NSButton!
    weak var minimizeButton: NSButton!
    weak var zoomButton: NSButton!
    weak var titleView: TitleView!
    weak var divider: NSView!
    
    var initialLocation: NSPoint!
    
    init() {
        super.init(frame: NSMakeRect(0, 0, 0, 0))
        self.wantsLayer = true
        self.layer?.backgroundColor = Theme.whiteColor().CGColor
        
        let closeButton = NSWindow.standardWindowButton(.CloseButton, forStyleMask: NSResizableWindowMask)!
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        //self.addSubview(closeButton)
        //self.closeButton = closeButton
        
        let minimizeButton = NSWindow.standardWindowButton(.MiniaturizeButton, forStyleMask: NSResizableWindowMask)!
        minimizeButton.translatesAutoresizingMaskIntoConstraints = false
        //self.addSubview(minimizeButton)
        //self.minimizeButton = minimizeButton
        
        let zoomButton = NSWindow.standardWindowButton(.ZoomButton, forStyleMask: NSResizableWindowMask)!
        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        //self.addSubview(zoomButton)
        //self.zoomButton = zoomButton
        
        let titleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleView)
        self.titleView = titleView
        
        let divider = NSView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.wantsLayer = true
        divider.layer?.backgroundColor = Theme.dividerColor().CGColor
        //self.addSubview(divider)
        self.divider = divider
        
        //addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[close]-10-[minimize]-10-[zoom]", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: ["close": closeButton, "minimize": minimizeButton, "zoom": zoomButton]))
        //addConstraint(NSLayoutConstraint(item: closeButton, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        //addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[divider]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["divider": divider]))
        //addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[divider(==0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["divider": divider]))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override func mouseDown(theEvent: NSEvent) {
        let frame = window!.frame
        
        initialLocation = NSEvent.mouseLocation()
        initialLocation.x -= frame.origin.x
        initialLocation.y -= frame.origin.y
    }
    
    private override func mouseDragged(theEvent: NSEvent) {
        var origin = NSPoint()
        let frame = window!.frame
        let screen = NSScreen.mainScreen()!.frame
        
        let currentLocation = NSEvent.mouseLocation()
        origin.x = currentLocation.x - initialLocation.x
        origin.y = currentLocation.y - initialLocation.y
        
        if origin.y + frame.size.height > screen.origin.y + screen.size.height {
            origin.y = screen.origin.y + (screen.size.height - frame.size.height)
        }
        
        window?.setFrameOrigin(origin)
    }
}

class NavigationController: NSViewController {
    
    override func loadView() {
        view = NavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

//
//  SelectionOptionsViewController.swift
//  Lux
//
//  Created by James Pickering on 2/5/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

class SelectionOptionButton: NSButton {
    var titleColor: NSColor! {
        didSet {
            let attrTitle = NSMutableAttributedString(attributedString: attributedTitle)
            attrTitle.addAttribute(NSForegroundColorAttributeName, value: titleColor, range: NSMakeRange(0, attrTitle.length))
            attributedTitle = attrTitle
        }
    }
    private weak var hairline: NSView!
    var showsHairline: Bool! {
        didSet {
            if showsHairline == false {
                if self.hairline == nil {
                    return
                }
                self.hairline.removeFromSuperview()
                return
            }
            
            let hairline = NSView()
            hairline.translatesAutoresizingMaskIntoConstraints = false
            hairline.wantsLayer = true
            hairline.layer?.backgroundColor = Theme.dividerColor().CGColor
            addSubview(hairline)
            self.hairline = hairline
            
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[hairline(==0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["hairline": hairline]))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[hairline]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["hairline": hairline]))
        }
    }
    
    init() {
        super.init(frame: NSMakeRect(0, 0, 0, 0))
        self.bordered = false
        self.font = Theme.font(13)
        self.wantsLayer = true
        self.layer?.backgroundColor = Theme.clearColor().CGColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mouseDown(theEvent: NSEvent) {
        layer?.backgroundColor = Theme.greenColor().CGColor
        titleColor = Theme.whiteColor()
        
    }
    
    override func mouseUp(theEvent: NSEvent) {
        layer?.backgroundColor = Theme.clearColor().CGColor
        titleColor = Theme.whiteColor()
    }
}

class SelectionOptionsViewController: NSViewController {

    override func loadView() {
        let view = NSView()
        view.wantsLayer = true
        //view.layer?.backgroundColor = Theme.whiteColor(0.8).CGColor
        self.view = view
        
        let defineButton = SelectionOptionButton()
        defineButton.translatesAutoresizingMaskIntoConstraints = false
        defineButton.title = "Define"
        defineButton.titleColor = Theme.brownColor()
        defineButton.showsHairline = true
        defineButton.action = "test"
        defineButton.target = self
        view.addSubview(defineButton)
        
        let commentButton = SelectionOptionButton()
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        commentButton.title = "Comment"
        commentButton.titleColor = Theme.brownColor()
        commentButton.showsHairline = true
        commentButton.action = "test"
        commentButton.target = self
        view.addSubview(commentButton)
        
        let translateButton = SelectionOptionButton()
        translateButton.translatesAutoresizingMaskIntoConstraints = false
        translateButton.title = "Translate"
        translateButton.titleColor = Theme.brownColor()
        translateButton.action = "test"
        translateButton.target = self
        view.addSubview(translateButton)
        
        let metrics = ["defineWidth": defineButton.attributedTitle.size().width + 24, "commentWidth": commentButton.attributedTitle.size().width + 24, "translateWidth": translateButton.attributedTitle.size().width + 24]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[define(==defineWidth)][comment(==commentWidth)][translate(==translateWidth)]|", options: [.AlignAllTop, .AlignAllBottom], metrics: metrics, views: ["define": defineButton, "comment": commentButton, "translate": translateButton]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[define]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["define": defineButton]))
    }
    
    func test() {
        console("test")
    }
}

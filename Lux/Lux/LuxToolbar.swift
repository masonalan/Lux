//
//  LuxToolbar.swift
//  Lux
//
//  Created by James Pickering on 2/7/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

extension K {
    static let LuxToolbarItemButtonCommentIdentifier = "LuxToolbarItemButtonComment"
    static let LuxToolbarItemButtonDefineIdentifier = "LuxToolbarItemButtonDefine"
    static let LuxToolbarItemButtonTranslateIdentifier = "LuxToolbarItemButtonTranslate"
}

class LuxToolbarItemButtonCell: NSButtonCell {
    
    override func highlight(flag: Bool, withFrame cellFrame: NSRect, inView controlView: NSView) {
        if flag == true {
            controlView.layer?.backgroundColor = Theme.buttonSelectedBackgroundColor().CGColor
        } else {
            controlView.layer?.backgroundColor = Theme.buttonBackgroundColor().CGColor
        }
    }
}

class LuxToolbarItemButton: NSButton {
    weak var imageView: NSImageView!
    var valid: Bool = false {
        didSet {
            if valid == true {
                imageView.alphaValue = 0.7
            } else {
                imageView.alphaValue = 0.3
            }
        }
    }
    
    init(image: String) {
        super.init(frame: NSMakeRect(0, 0, 0, 0))
        self.cell = LuxToolbarItemButtonCell()
        self.wantsLayer = true
        self.layer?.backgroundColor = Theme.buttonBackgroundColor().CGColor
        self.layer?.cornerRadius = 3.0
        self.bordered = false
        self.title = ""
        
        let imageView = NSImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = NSImage(named: image)!.tinted(Theme.brownColor())
        imageView.alphaValue = 0.3
        self.addSubview(imageView)
        self.imageView = imageView
        
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 15.0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 15.0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

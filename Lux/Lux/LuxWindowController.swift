//
//  WindowController.swift
//  Lux
//
//  Created by James Pickering on 2/4/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

extension K {
    static let LuxToolbarIdentifier = "LuxToolbar"
}

class LuxWindowController: NSWindowController {
    weak var defineToolbarItem: NSToolbarItem!
    weak var commentToolbarItem: NSToolbarItem!
    weak var translateToolbarItem: NSToolbarItem!
    
    let editorController: EditorViewController
    
    init() {
        self.editorController = EditorViewController()
        
        let window = LuxWindow(contentRect: NSMakeRect(100, 100, 1000, 700), styleMask: NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask | NSFullSizeContentViewWindowMask, backing: NSBackingStoreType.Buffered, `defer`: false)
        window.center()
        window.titleVisibility = .Hidden
        window.titlebarAppearsTransparent = true
        window.backgroundColor = Theme.whiteColor()
        window.hasShadow = true
        window.contentView?.addSubview(editorController.view)
        window.contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[editor]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["editor": editorController.view]))
        window.contentView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-38-[editor]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["editor": editorController.view]))
        window.makeKeyAndOrderFront(nil)
        
        super.init(window: window)
        
        let toolbar = NSToolbar(identifier: K.LuxToolbarIdentifier)
        toolbar.delegate = self
        window.toolbar = toolbar
        
        self.editorController.latinController.latinView.highlightingDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func define() {
    
    }
    
    func comment() {
        editorController.latinController.comment()
    }
    
    func translate() {
        editorController.latinController.translate()
    }
}

extension LuxWindowController: LatinHighlightingDelegate {
    
    func validateDefineAction(flag: Bool) {
        validate(defineToolbarItem, flag: flag)
    }
    
    func validateCommentAction(flag: Bool) {
        validate(commentToolbarItem, flag: flag)
    }
    
    func validateTranslateAction(flag: Bool) {
        validate(translateToolbarItem, flag: flag)
    }
    
    func validate(item: NSToolbarItem, flag: Bool) {
        item.enabled = flag
        (item.view as! LuxToolbarItemButton).valid = flag
        window?.toolbar?.validateVisibleItems()
    }
}

extension LuxWindowController: NSToolbarDelegate {
    
    func toolbarSelectableItemIdentifiers(toolbar: NSToolbar) -> [String] {
        return [K.LuxToolbarItemButtonDefineIdentifier, K.LuxToolbarItemButtonCommentIdentifier, K.LuxToolbarItemButtonTranslateIdentifier]
    }
    
    func toolbarAllowedItemIdentifiers(toolbar: NSToolbar) -> [String] {
        return [K.LuxToolbarItemButtonDefineIdentifier, K.LuxToolbarItemButtonCommentIdentifier, K.LuxToolbarItemButtonTranslateIdentifier, NSToolbarFlexibleSpaceItemIdentifier, NSToolbarSeparatorItemIdentifier, NSToolbarSpaceItemIdentifier]
    }
    
    func toolbarDefaultItemIdentifiers(toolbar: NSToolbar) -> [String] {
        return [NSToolbarFlexibleSpaceItemIdentifier, K.LuxToolbarItemButtonDefineIdentifier, K.LuxToolbarItemButtonCommentIdentifier, K.LuxToolbarItemButtonTranslateIdentifier, NSToolbarFlexibleSpaceItemIdentifier]
    }
    
    func toolbar(toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        let item = NSToolbarItem(itemIdentifier: itemIdentifier)
        item.maxSize = NSMakeSize(44.0, 22.0)
        
        if itemIdentifier == K.LuxToolbarItemButtonDefineIdentifier {
            item.view = LuxToolbarItemButton(image: "Define")
            item.action = "define"
            item.target = self
            item.enabled = false
            defineToolbarItem = item
        } else if itemIdentifier == K.LuxToolbarItemButtonCommentIdentifier {
            item.view = LuxToolbarItemButton(image: "Comment")
            item.action = "comment"
            item.target = self
            item.enabled = false
            commentToolbarItem = item
        } else if itemIdentifier == K.LuxToolbarItemButtonTranslateIdentifier {
            item.view = LuxToolbarItemButton(image: "Translate")
            item.action = "translate"
            item.target = self
            item.enabled = false
            translateToolbarItem = item
        }
        
        return item
    }
    
    override func validateToolbarItem(theItem: NSToolbarItem) -> Bool {
        return theItem.enabled
    }
}

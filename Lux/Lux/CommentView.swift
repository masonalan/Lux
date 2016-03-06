//
//  CommentView.swift
//  Lux
//
//  Created by James Pickering on 2/7/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

class CommentView: NSView {
    weak var commentLabel: NSTextField!
    weak var highlightBar: NSView!
    
    var highlightColor: NSColor = Theme.yellowColor() {
        didSet {
            highlightBar.layer?.backgroundColor = highlightColor.CGColor
        }
    }
    var trackingArea: NSTrackingArea?
    var highlightConstraints: [NSLayoutConstraint]?
    var highlighted: Bool = false {
        didSet {
            if selected == true {
                return
            }
            
            if highlightConstraints != nil {
                removeConstraints(highlightConstraints!)
            }
            
            highlightConstraints = [NSLayoutConstraint]()
            if highlighted == true {
                commentLabel.textColor = Theme.brownColor()
                highlightConstraints! += NSLayoutConstraint.constraintsWithVisualFormat("H:|[highlight]-10-[comment]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["comment": commentLabel, "highlight": highlightBar])
                highlightConstraints!.append(NSLayoutConstraint(item: highlightBar, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 2.0))
            } else if highlighted == false && selected == false {
                commentLabel.textColor = Theme.unfocusedColor()
                highlightConstraints! += NSLayoutConstraint.constraintsWithVisualFormat("H:|[comment]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["comment": commentLabel, "highlight": highlightBar])
                highlightConstraints!.append(NSLayoutConstraint(item: highlightBar, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0.0))
            }
            
            addConstraints(highlightConstraints!)
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                context.duration = 0.2
                context.allowsImplicitAnimation = true
                self.updateConstraintsForSubtreeIfNeeded()
                self.layoutSubtreeIfNeeded()
                }, completionHandler: nil)
        }
    }
    var selected: Bool = false {
        didSet {
            if highlighted == false && selected == true {
                highlighted = true
                if highlightConstraints != nil {
                    removeConstraints(highlightConstraints!)
                }
                highlightConstraints = [NSLayoutConstraint]()
                commentLabel.textColor = Theme.brownColor()
                highlightConstraints! += NSLayoutConstraint.constraintsWithVisualFormat("H:|[highlight]-10-[comment]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["comment": commentLabel, "highlight": highlightBar])
                highlightConstraints!.append(NSLayoutConstraint(item: highlightBar, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 2.0))
                addConstraints(highlightConstraints!)
                NSAnimationContext.runAnimationGroup({ (context) -> Void in
                    context.duration = 0.2
                    context.allowsImplicitAnimation = true
                    self.updateConstraintsForSubtreeIfNeeded()
                    self.layoutSubtreeIfNeeded()
                    }, completionHandler: nil)
            } else if selected == false {
                highlighted = false
            }
        }
    }
    
    init() {
        super.init(frame: NSMakeRect(0, 0, 0, 0))
        
        let commentLabel = NSTextField(frame: NSMakeRect(0, 0, 0 ,0))
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.textColor = Theme.unfocusedColor()
        commentLabel.font = Theme.font(13)
        commentLabel.editable = false
        commentLabel.bordered = false
        commentLabel.drawsBackground = false
        commentLabel.backgroundColor = Theme.clearColor()
        commentLabel.lineBreakMode = .ByWordWrapping
        commentLabel.focusRingType = .None
        commentLabel.setContentCompressionResistancePriority(NSLayoutPriorityWindowSizeStayPut, forOrientation: NSLayoutConstraintOrientation.Horizontal)
        self.addSubview(commentLabel)
        self.commentLabel = commentLabel
        
        let highlightBar = NSView()
        highlightBar.translatesAutoresizingMaskIntoConstraints = false
        highlightBar.wantsLayer = true
        highlightBar.layer?.backgroundColor = highlightColor.CGColor
        self.addSubview(highlightBar)
        self.highlightBar = highlightBar
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(-2)-[comment]-(2)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["comment": commentLabel]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[highlight]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["highlight": highlightBar]))
        
        self.highlightConstraints = [NSLayoutConstraint]()
        self.highlightConstraints! += NSLayoutConstraint.constraintsWithVisualFormat("H:|[comment]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["comment": commentLabel, "highlight": highlightBar])
        self.highlightConstraints!.append(NSLayoutConstraint(item: highlightBar, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0.0))
        self.addConstraints(self.highlightConstraints!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func resizeSubviewsWithOldSize(oldSize: NSSize) {
        super.resizeSubviewsWithOldSize(oldSize)
        if oldSize == bounds.size {
            return
        }
        
        if trackingArea != nil {
            removeTrackingArea(trackingArea!)
        }
        
        trackingArea = NSTrackingArea(rect: bounds, options: [.MouseEnteredAndExited, .MouseMoved, .ActiveAlways], owner: self, userInfo: nil)
        addTrackingArea(trackingArea!)
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        NSCursor.pointingHandCursor().set()
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        highlighted = true
    }
    
    override func mouseExited(theEvent: NSEvent) {
        highlighted = false
    }
}

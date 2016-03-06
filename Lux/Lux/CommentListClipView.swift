//
//  CommentListClipView.swift
//  Lux
//
//  Created by James Pickering on 2/7/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

class CommentListClipView: NSClipView {
    //var commentListView: CommentListView?
    
    override func constrainBoundsRect(proposedBounds: NSRect) -> NSRect {
        //return super.constrainBoundsRect(proposedBounds)
        var constrainedClip = super.constrainBoundsRect(proposedBounds)
        //let documentFrame = documentView!.frame
        
        //constrainedClip.size.height = commentListView!.contentHeight
        /*if proposedBounds.size.height >= documentFrame.size.height {
            let a = documentFrame.size.height / 2.0
            let b = commentListView!.contentHeight / 2.0
            constrainedClip.origin.y = a + b
            
        } /*else if proposedBounds.size.height == documentFrame.size.height {
        return super.constrainBoundsRect(proposedBounds)
        }*/*/
        
        console(constrainedClip)
        
        return constrainedClip
    }
    
    func centeredCoordUnit(proposedBoundsDimension: CGFloat, documentFrameDimension: CGFloat) -> CGFloat {
        return floor((proposedBoundsDimension - documentFrameDimension) / 2.0)
    }
}

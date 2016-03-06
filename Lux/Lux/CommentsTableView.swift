//
//  CommentsTableView.swift
//  Lux
//
//  Created by James Pickering on 2/8/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

class CommentsTableView: NSTableView {
    
    init() {
        super.init(frame: NSMakeRect(0, 10, 0, 0))
        self.focusRingType = .None
        self.headerView = nil
        self.backgroundColor = Theme.clearColor()
        self.intercellSpacing = NSMakeSize(0, 20.0)
        self.selectionHighlightStyle = .None
        
        let column = NSTableColumn(identifier: K.CommentsTableViewColumnIdentifier)
        column.width = 50
        self.addTableColumn(column)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func resizeSubviewsWithOldSize(oldSize: NSSize) {
        super.resizeSubviewsWithOldSize(oldSize)
        noteHeightOfRowsWithIndexesChanged(NSIndexSet(indexesInRange: rowsInRect(visibleRect)))
    }
}

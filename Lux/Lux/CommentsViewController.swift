//
//  CommentsViewController.swift
//  Lux
//
//  Created by James Pickering on 2/5/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

extension K {
    static let CommentsTableViewColumnIdentifier = "CommentsTableViewColumnIdentifier"
}

class CommentsViewController: NSViewController {
    weak var tableView: CommentsTableView!
    weak var selectedComment: CommentView?
    let comments = ["Ablative", "= ne ut", "dat. of location", "chief of police is in the house", "Anotha comment", "Another one", "lsdkfj sfdlkjfds dfslkdsflkjsdfjl fdlsflkjjf fdkdfjdfjkdfls df kdflksklsdj fdslsdfklsfdjsflk", "That was a test", "Should I do....", "Anotha one?", "Sheesh", "Scrolling works?", "Or naw", "or saw or saw or saw or saw or saw"]
    
    override func loadView() {
        let view = NSScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.drawsBackground = false
        self.view = view
        
        let tableView = CommentsTableView()
        tableView.autoresizingMask = [.ViewWidthSizable, .ViewHeightSizable]
        tableView.setDelegate(self)
        tableView.setDataSource(self)
        view.documentView = tableView
        view.documentView?.scrollPoint(NSMakePoint(0, 100))
        self.tableView = tableView
    }
}

extension CommentsViewController: NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = CommentView()
        view.commentLabel.stringValue = "\(row + 1). " + comments[row]
        return view
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let style = NSParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        style.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        let comment = NSMutableAttributedString(string: "\(row + 1). " + comments[row])
        comment.addAttributes([NSFontAttributeName: Theme.font(13), NSParagraphStyleAttributeName: style], range: NSMakeRange(0, comment.length))
        return comment.boundingRectWithSize(NSMakeSize(view.frame.size.width - 12, CGFloat(FLT_MAX)), options: [.UsesFontLeading, .UsesLineFragmentOrigin]).height
    }
}

extension CommentsViewController: NSTableViewDataSource {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return comments.count
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        selectedComment?.selected = false
        let cell = tableView.viewAtColumn(0, row: notification.object!.selectedRow, makeIfNecessary: false) as! CommentView
        console(cell.commentLabel.stringValue)
        cell.selected = true
        selectedComment = cell
    }
}

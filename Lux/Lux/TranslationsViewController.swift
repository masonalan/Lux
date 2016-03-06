//
//  TranslationsViewController.swift
//  Lux
//
//  Created by James Pickering on 2/10/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

class TranslationsViewController: NSViewController {
    weak var tableView: CommentsTableView!
    var selectedTranslation: CommentView?
    let translations = ["Lorem Khaled Ipsum is a major key to success. Always remember in the jungle there’s a lot of they in there, after you overcome they, you will make it to paradise. Let’s see what Chef Dee got that they don’t want us to eat. Egg whites, turkey sausage, wheat toast, water. Of course they don’t want us to eat our breakfast, so we are going to enjoy our breakfast. Every chance I get, I water the plants, Lion! The weather is amazing, walk with me through the pathway of more success. Take this journey with me, Lion!", "Find peace, life is like a water fall, you’ve gotta flow. They don’t want us to eat. The key to more success is to get a massage once a week, very important, major key, cloth talk. It’s on you how you want to live your life. Everyone has a choice. I pick my choice, squeaky clean. How’s business? Boomin. Special cloth alert. To succeed you must believe. When you believe, you will succeed.", "I’m giving you cloth talk, cloth. Special cloth alert, cut from a special cloth. Find peace, life is like a water fall, you’ve gotta flow. We don’t see them, we will never see them. Look at the sunset, life is amazing, life is beautiful, life is what you make it. Life is what you make it, so let’s make it. Cloth talk. You do know, you do know that they don’t want you to have lunch. I’m keeping it real with you, so what you going do is have lunch.", "Give thanks to the most high. Watch your back, but more importantly when you get out the shower, dry your back, it’s a cold world out there. The key is to enjoy life, because they don’t want you to enjoy life. I promise you, they don’t want you to jetski, they don’t want you to smile. The key is to enjoy life, because they don’t want you to enjoy life. I promise you, they don’t want you to jetski, they don’t want you to smile. Mogul talk."]
    
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
        self.tableView = tableView
    }
}

extension TranslationsViewController: NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = CommentView()
        view.commentLabel.stringValue = "\(row + 1). " + translations[row]
        view.highlightColor = Theme.greenColor()
        return view
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let style = NSParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        style.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        let comment = NSMutableAttributedString(string: "\(row + 1). " + translations[row])
        comment.addAttributes([NSFontAttributeName: Theme.font(13), NSParagraphStyleAttributeName: style], range: NSMakeRange(0, comment.length))
        return comment.boundingRectWithSize(NSMakeSize(view.frame.size.width - 12, CGFloat(FLT_MAX)), options: [.UsesFontLeading, .UsesLineFragmentOrigin]).height
    }
}

extension TranslationsViewController: NSTableViewDataSource {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return translations.count
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        selectedTranslation?.selected = false
        let cell = tableView.viewAtColumn(0, row: notification.object!.selectedRow, makeIfNecessary: false) as! CommentView
        cell.selected = true
        selectedTranslation = cell
    }
}

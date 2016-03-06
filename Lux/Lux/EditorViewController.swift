//
//  EditorViewController.swift
//  Lux
//
//  Created by James Pickering on 2/4/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

class EditorViewController: NSViewController {
    var latinController: LatinViewController
    var commentsController: CommentsViewController
    var translationsController: TranslationsViewController
    
    init() {
        self.commentsController = CommentsViewController()
        self.latinController = LatinViewController()
        self.translationsController = TranslationsViewController()
        
        super.init(nibName: nil, bundle: nil)!
        
        self.addChildViewController(self.commentsController)
        self.addChildViewController(self.latinController)
        self.addChildViewController(self.translationsController)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsLayer = true
        view.layer?.backgroundColor = Theme.whiteColor().CGColor
        self.view = view
        
        view.addSubview(commentsController.view)
        view.addSubview(latinController.view)
        view.addSubview(translationsController.view)

        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-50-[comments(>=100)]-50-[text]-50-[translations]-50-|", options: [.AlignAllBottom, .AlignAllTop], metrics: nil, views: ["comments": commentsController.view, "text": latinController.view, "translations": translationsController.view]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[comments(>=500)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["comments": commentsController.view]))
        view.addConstraint(NSLayoutConstraint(item: commentsController.view, attribute: .Width, relatedBy: .Equal, toItem: latinController.view, attribute: .Width, multiplier: 0.25, constant: 1.0))
        view.addConstraint(NSLayoutConstraint(item: commentsController.view, attribute: .Width, relatedBy: .Equal, toItem: translationsController.view, attribute: .Width, multiplier: 0.5, constant: 1.0))
    }
}

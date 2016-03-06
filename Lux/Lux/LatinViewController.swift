//
//  TextViewController.swift
//  Lux
//
//  Created by James Pickering on 2/4/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

protocol LatinViewControllerDelegate {
    func validateDefineAction(flag: Bool)
    func validateCommentAction(flag: Bool)
    func validateTranslateAction(flag: Bool)
}

class LatinViewController: NSViewController {
    var delegate: LatinViewControllerDelegate?
    var latinView: LatinView!
    
    override func loadView() {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view = view
        
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.drawsBackground = false
        
        /*let latinView = LatinView()
        latinView.autoresizingMask = [.ViewWidthSizable]
        //latinView.translatesAutoresizingMaskIntoConstraints = false
        //latinView.setContentHuggingPriority(NSLayoutPriorityWindowSizeStayPut + 1.0, forOrientation: .Horizontal)
        latinView.wantsLayer = true
        latinView.layer?.backgroundColor = Theme.greenColor().CGColor
        self.latinView = latinView*/
        
        let latinView = LatinView()
        latinView.autoresizingMask = [.ViewWidthSizable]
        latinView.string = "Anna refert: “O luce magis dilecta sorori, solane perpetua maerens carpere iuventa, nec dulcis natos, Veneris nec praemia noris? Id cinerem aut Manis credis curare sepultos? Esto: aegram nulli quondam flexere mariti, non Libyae, non ante Tyro; despectus Iarbas ductoresque alii, quos Africa terra triumphis dives alit: placitone etiam pugnabis amori? Nec venit in mentem, quorum consederis arvis? Hinc Gaetulae urbes, genus insuperabile bello, et Numidae infreni cingunt et inhospita Syrtis; hinc deserta siti regio, lateque furentes barcaei. Quid bella Tyro surgentia dicam, germanique minas? Dis equidem auspicibus reor et Iunone secunda hunc cursum Iliacas vento tenuisse carinas.Quam tu urbem, soror, hanc cernes, quae surgere regnaconiugio tali! Teucrum comitantibus armisPunica se quantis attollet gloria rebus! Tu modo posce deos veniam, sacrisque litatis indulge hospitio, causasque innecte morandi, dum pelago desaevit hiemps et aquosus Orion, quassataeque rates, dum non tractabile caelum.”"
        self.latinView = latinView
        
        scrollView.documentView = latinView
        view.addSubview(scrollView)
        
        //scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scroll]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["scroll": latinView]))
        //scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scroll]", options: NSLayoutFormatOptions(), metrics: nil, views: ["scroll": latinView]))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scroll]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["scroll": scrollView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scroll]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["scroll": scrollView]))
    }
    
    func comment() {
        latinView.highlightComment()
    }
    
    func translate() {
        latinView.underlineTranslatedText()
    }
}

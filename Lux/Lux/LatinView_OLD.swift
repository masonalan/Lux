////
////  LatinView.swift
////  Lux
////
////  Created by James Pickering on 2/8/16.
////  Copyright © 2016 James Pickering. All rights reserved.
////
//
//import Cocoa
//
//
//
//class LatinViewOLD: NSView {
//    var textView: LatinTextView!
//    var highlights: [Highlight]
//    
//    init() {
//        self.highlights = [Highlight]()
//        super.init(frame: NSMakeRect(0, 0, 0, 0))
//        
//        let textView = LatinTextView()
//        //textView.autoresizingMask = [.ViewWidthSizable]
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        //textView.setContentHuggingPriority(NSLayoutPriorityRequired, forOrientation: .Horizontal)
//        textView.string = "Anna refert: “O luce magis dilecta sorori, solane perpetua maerens carpere iuventa, nec dulcis natos, Veneris nec praemia noris? Id cinerem aut Manis credis curare sepultos? Esto: aegram nulli quondam flexere mariti, non Libyae, non ante Tyro; despectus Iarbas ductoresque alii, quos Africa terra triumphis dives alit: placitone etiam pugnabis amori? Nec venit in mentem, quorum consederis arvis? Hinc Gaetulae urbes, genus insuperabile bello, et Numidae infreni cingunt et inhospita Syrtis; hinc deserta siti regio, lateque furentes barcaei. Quid bella Tyro surgentia dicam, germanique minas? Dis equidem auspicibus reor et Iunone secunda hunc cursum Iliacas vento tenuisse carinas.Quam tu urbem, soror, hanc cernes, quae surgere regnaconiugio tali! Teucrum comitantibus armisPunica se quantis attollet gloria rebus! Tu modo posce deos veniam, sacrisque litatis indulge hospitio, causasque innecte morandi, dum pelago desaevit hiemps et aquosus Orion, quassataeque rates, dum non tractabile caelum.”"
//        self.addSubview(textView)
//        self.textView = textView
//        
//        //self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[text]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["text": textView]))
//        //self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[text]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["text": textView]))
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layout() {
//        super.layout()
//        invalidateIntrinsicContentSize()
//    }
//    
//    override func resizeSubviewsWithOldSize(oldSize: NSSize) {
//        super.resizeSubviewsWithOldSize(oldSize)
//    }
//}

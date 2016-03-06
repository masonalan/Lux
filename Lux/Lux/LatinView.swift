//
//  LatinTextView.swift
//  Lux
//
//  Created by James Pickering on 2/7/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

struct Highlight {
    var layers: [CALayer]
    var range: NSRange
    
    init(rects: [NSRect], range: NSRange) {
        self.range = range
        self.layers = [CALayer]()
        for var rect in rects {
            let layer = CALayer()
            rect.origin.y += 20
            layer.frame = rect
            layer.backgroundColor = Theme.yellowColor(0.4).CGColor
            self.layers.append(layer)
        }
    }
    
    func selected(point: NSPoint) -> Bool {
        for layer in layers {
            if NSPointInRect(point, layer.frame) == true {
                select()
                return true
            }
        }
        return false
    }
    
    func select() {
        for layer in layers {
            layer.backgroundColor = Theme.yellowColor().CGColor
        }
    }
    
    func deselect() {
        for layer in layers {
            layer.backgroundColor = Theme.yellowColor(0.4).CGColor
        }
    }
}

protocol LatinHighlightingDelegate {
    func validateDefineAction(flag: Bool)
    func validateCommentAction(flag: Bool)
    func validateTranslateAction(flag: Bool)
}

class LatinView: NSTextView {
    var highlights: [Highlight]
    var highlightingDelegate: LatinHighlightingDelegate?
    var selectedRects: [NSRect] {
        var rectCount = 1
        let rectArray = layoutManager!.rectArrayForCharacterRange(selectedRanges.first!.rangeValue, withinSelectedCharacterRange: selectedRanges.first!.rangeValue, inTextContainer: textContainer!, rectCount: &rectCount)
        var rects = [NSRect]()
        for i in 0..<rectCount {
            rects.append(rectArray[i])
        }
        
        return rects
    }
    
    private var textLayer: CALayer!
    
    override var intrinsicContentSize: NSSize {
        console("Bounds: \(bounds)")
        layoutManager!.ensureLayoutForTextContainer(textContainer!)
        console(layoutManager!.usedRectForTextContainer(textContainer!).size)
        return layoutManager!.usedRectForTextContainer(textContainer!).size
    }
    
    init() {
        self.highlights = [Highlight]()
        
        let t = NSTextView(frame: NSMakeRect(0, 0, 0, 0))
        super.init(frame: t.frame, textContainer: t.textContainer)
        
        self.minSize = NSMakeSize(0, 0)
        self.maxSize = NSMakeSize(0, CGFloat(FLT_MAX))
        self.verticallyResizable = true
        self.horizontallyResizable = false
        self.textContainer?.heightTracksTextView = false
        self.textColor = Theme.brownColor()
        self.font = Theme.font(17)
        self.wantsLayer = true
        self.editable = false
        self.textContainerInset = NSMakeSize(0, 20)
        self.backgroundColor = Theme.clearColor()
        self.selectedTextAttributes = [NSBackgroundColorAttributeName: Theme.highlightColor()]
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 27
        self.defaultParagraphStyle = style
        
        self.textLayer = self.layer!.sublayers!.last
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didChangeText() {
        super.didChangeText()
        invalidateIntrinsicContentSize()
    }
    
    override func resizeSubviewsWithOldSize(oldSize: NSSize) {
        super.resizeSubviewsWithOldSize(oldSize)
        invalidateIntrinsicContentSize()
        minSize = bounds.size
        maxSize = NSMakeSize(bounds.size.width, CGFloat(FLT_MAX))
    }
    
    override func setSelectedRange(charRange: NSRange) {
        super.setSelectedRange(charRange)
    }
    
    override func setSelectedRange(charRange: NSRange, affinity: NSSelectionAffinity, stillSelecting stillSelectingFlag: Bool) {
        super.setSelectedRange(charRange, affinity: affinity, stillSelecting: stillSelectingFlag)
        
        let selectedText = NSString(string: string!).substringWithRange(charRange)
        if selectedText == "" {
            Lux.windowController()?.validateDefineAction(false)
            Lux.windowController()?.validateCommentAction(false)
            Lux.windowController()?.validateTranslateAction(false)
            
            let glyphRange = layoutManager!.glyphRangeForCharacterRange(charRange, actualCharacterRange: nil)
            console(glyphRange)
            
            for highlight in highlights {
                highlight.deselect()
            }
            for highlight in highlights {
                if NSLocationInRange(glyphRange.location, highlight.range) == true {
                    console("HIT")
                    highlight.select()
                    return
                }
            }
            
            return
        }
        Lux.windowController()?.validateDefineAction(!selectedText.containsString(" "))
        Lux.windowController()?.validateCommentAction(true)
        Lux.windowController()?.validateTranslateAction(true)
    }
    
    func highlightComment() {
        //layoutManager?.addTemporaryAttribute(NSBackgroundColorAttributeName, value: Theme.yellowColor(0.4), forCharacterRange: selectedRange())
        
        let highlight = Highlight(rects: selectedRects, range: selectedRange())
        for layer in highlight.layers {
            self.layer?.insertSublayer(layer, below: textLayer)
        }
        highlights.append(highlight)
    }
    
    func underlineTranslatedText() {
        layoutManager?.addTemporaryAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleThick.rawValue, forCharacterRange: selectedRange())
        layoutManager?.addTemporaryAttribute(NSUnderlineColorAttributeName, value: Theme.greenColor(), forCharacterRange: selectedRange())
    }
}

//
//  Entry.swift
//  Whitaker
//
//  Created by James Pickering on 2/1/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Foundation

public struct Entry {
    public var definitions: [String]
    public var principleParts: String
    public var interpretations: [Word]
    public var pos: POS
    
    static func fromLines(lines: [String]) throws -> Entry {
        let count = lines.count
        
        var definitions = lines.last!.componentsSeparatedByString("; ")
        if definitions.last! == "" {
            definitions.removeLast()
        }
        
        let wordLine = lines[count - 2]
        let components = wordLine.componentsSeparatedByString("  ")
        let principleParts = components.first!
        
        let pos: POS
        do {
            pos = try POS(string: components[1])
        } catch let e {
            throw e
        }
        
        var interpretations = [Word]()
        for i in 0...count - 3 {
            do {
                let word = try Word.fromLine(lines[i])
                interpretations.append(word)
            } catch let e {
                throw e
            }
        }
        
        return Entry(definitions: definitions, principleParts: principleParts, interpretations: interpretations, pos: pos)
    }
}

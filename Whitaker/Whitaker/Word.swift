//
//  Word.swift
//  Whitaker
//
//  Created by James Pickering on 2/1/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Cocoa

public enum POSError: ErrorType {
    case InvalidString(s: String)
}

public enum POS {
    
    case Noun, Verb, Adjective
    
    init(string: String) throws {
        switch string {
        case "N":
            self = .Noun
            break
        default:
            throw POSError.InvalidString(s: string)
        }
    }
}

public typealias Declension = Int
public enum Case {
    case Nomnative, Genative, Dative, Accusative, Ablative, Vocative, Locative, X
    
    init(string: String) {
        switch string {
        case "NOM":
            self = .Nomnative
            break
        case "GEN":
            self = .Genative
            break
        case "DAT":
            self = .Dative
            break
        case "ACC":
            self = .Accusative
            break
        case "ABL":
            self = .Ablative
            break
        case "VOC":
            self = .Vocative
            break
        case "LOC":
            self = .Locative
            break
        default:
            self = .X
            break
        }
    }
    
    var string: String {
        switch self {
        case .Nomnative:
            return "Nom"
        case .Genative:
            return "Gen"
        case .Dative:
            return "Dat"
        case .Accusative:
            return "Acc"
        case .Ablative:
            return "Abl"
        case .Locative:
            return "Loc"
        case .Vocative:
            return "Voc"
        default:
            return "X"
        }
        
    }
}

public enum Gender {
    case Masculine, Feminine, Neuter, Common, X
    
    init(string: String) {
        switch string {
        case "M":
            self = .Masculine
            break
        case "F":
            self = .Feminine
            break
        case "N":
            self = .Neuter
            break
        case "C":
            self = .Common
            break
        default:
            self = .X
            break
        }
    }
    
    var string: String {
        switch self {
        case .Masculine:
            return "Masc"
        case .Feminine:
            return "Fem"
        case .Neuter:
            return "Neut"
        case .Common:
            return "Com"
        case .X:
            return "X"
        }
    }
}

public protocol WordDescriptor {
    var description: String { get }
}

public enum WordError: ErrorType {
    case InvalidRegex, InvalidPartOfSpeech, PartOfSpeechNotSupported
}

public class Word: WordDescriptor {
    private(set) public var stem: String
    private(set) public var ending: String
    private(set) public var pos: POS
    
    public var value: String {
        return stem + ending
    }
    
    public var description: String {
        return "WORD"
    }
    
    static func fromLine(line: String) throws -> Word {
        
        let components: [String]
        do {
            let c = try line.regex("\\s{2,}", replace: " ")
            components = c.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        } catch let e {
            throw e
        }
        
        let pos: POS
        do {
            pos = try POS(string: components[1])
        } catch let e {
            throw e
        }
        
        switch pos {
        case .Noun:
            return Noun(components: components)
        default:
            throw WordError.PartOfSpeechNotSupported
        }
    }
    
    init(components: [String], pos: POS) {
        self.pos = pos
        if components[0].containsString(".") {
            let split = components[0].componentsSeparatedByString(".")
            self.stem = split[0]
            self.ending = split[1]
        } else {
            self.stem = components[0]
            self.ending = ""
        }
    }
}

public class Noun: Word {
    private(set) var gender: Gender
    private(set) var declension: Declension
    private(set) var casetype: Case
    
    init(components: [String]) {
        self.declension = Declension(components[2])!
        self.casetype = Case(string: components[4])
        self.gender = Gender(string: components[6])
        
        super.init(components: components, pos: .Noun)
    }
    
    override public var description: String {
        return "\(value): \(pos), \(gender.string), \(casetype.string), \(declension)"
    }
}

extension String {
    func regex(r: String, replace: String) throws -> String {
        let regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: r, options: .CaseInsensitive)
        } catch let e {
            throw e
        }
        let length = self.characters.count
        return regex.stringByReplacingMatchesInString(self, options: NSMatchingOptions(), range: NSMakeRange(0, length), withTemplate: replace)
    }
}

//
//  Whitaker.swift
//  Whitaker
//
//  Created by James Pickering on 2/1/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Alamofire
import Kanna

public enum WhitakerError: ErrorType {
    case Alamofire(error: NSError)
    case InvalidHTMLResponse
    case NoPreTagFound
}

public struct Whitaker {
    public static func query(q: String, completion: ([Entry]?, String?) -> ()) {
        print("--------------------\n| Query: \(q)\n--------------------")
        Alamofire.request(.GET, "http://archives.nd.edu/cgi-bin/wordz.pl", parameters: ["keyword": q]).responseString(completionHandler: { (response) -> Void in
            if let e = response.result.error {
                completion(nil, String(WhitakerError.Alamofire(error: e)))
                return
            }
            
            guard let doc = Kanna.HTML(html: response.result.value!, encoding: NSUTF8StringEncoding) else {
                completion(nil, String(WhitakerError.InvalidHTMLResponse))
                return
            }
            
            guard let rStr = doc.css("pre").text else {
                completion(nil, String(WhitakerError.NoPreTagFound))
                return
            }
            
            var entries = [Entry]()
            var allLines = rStr.componentsSeparatedByString("\n")
            allLines.removeLast()
            allLines.removeFirst()
            
            var entryLines = [String]()
            for line in allLines {
                if line == "" {
                    continue
                }
                entryLines.append(line)
                if line.characters.last == ";" {
                    do {
                        let entry = try Entry.fromLines(entryLines)
                        entries.append(entry)
                        entryLines.removeAll()
                    } catch POSError.InvalidString(let pos) {
                        print("| ! Invalid part of speech \"\(pos)\"")
                        entryLines.removeAll()
                    } catch let e {
                        completion(nil, String(e))
                        return
                    }
                }
            }
            
            completion(entries, nil)
        })
        print("| * Request sent...")
    }
}

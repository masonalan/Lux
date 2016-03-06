//
//  main.swift
//  DictionaryTest
//
//  Created by James Pickering on 2/1/16.
//  Copyright © 2016 James Pickering. All rights reserved.
//

import Whitaker

Whitaker.query("liber") { (entries, error) -> () in
    if let e = error {
        print(e)
        return
    }
    
    print("--------------------\n| Results\n--------------------")
    for entry in entries! {
        print("| * \(entry.principleParts):")
        var definition = "    "
        for d in entry.definitions {
            definition += d
        }
        print("\(definition)\n    ----------------")
        for word in entry.interpretations {
            print("  - \(word.description)")
        }
        print("")
    }
}

NSRunLoop.mainRunLoop().run()
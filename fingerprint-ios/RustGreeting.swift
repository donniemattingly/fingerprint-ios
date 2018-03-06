//
//  RustGreeting.swift
//  fingerprint-ios
//
//  Created by Donnie Mattingly on 2/28/18.
//  Copyright © 2018 Donnie Mattingly. All rights reserved.
//

import Foundation

class RustGreetings {
    func sayHello(to: String) -> String {
        let result = rust_greeting(to)
        let swift_result = String(cString: result!)
        rust_greeting_free(UnsafeMutablePointer(mutating: result))
        return swift_result
    }
    
    func calculateHashes() {
        let finished = rust_compute_hashes("Test String")
        let array_size = rust_get_hashes_size();
        
        if var ptr = rust_get_hashes() {
            var strings: [String] = []
            while let s = ptr.pointee {
                strings.append(String(cString: s))
                ptr += 1
            }
            // Now p.pointee == nil.
            
            print(strings)
        }
    }
}

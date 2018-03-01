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
}

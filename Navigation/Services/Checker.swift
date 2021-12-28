//
//  Checker.swift
//  Navigation
//
//  Created by Denis Evdokimov on 12/28/21.
//

import Foundation
class Checker {
    static let shared = Checker()
    private init(){}
    private let login = "Test"
    private let pswd = "StrongPassword"
    
     func verify(log: String, pas: String)-> Bool {
        log == login && pas == pswd
        
    }
    
}

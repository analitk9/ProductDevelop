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
    private let login = "1"
    private let password = "1"
    
    func verify(login: String, password: String)-> Bool {
        self.login == login && self.password == password
    }
}

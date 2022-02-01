//
//  LoginInspector.swift
//  Navigation
//
//  Created by Denis Evdokimov on 12/28/21.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.shared.verify(login: login, password: password)
    }
}

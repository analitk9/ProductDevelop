//
//  LoginInspector.swift
//  Navigation
//
//  Created by Denis Evdokimov on 12/28/21.
//

import Foundation

class LoginInspector {
    
}

extension LoginInspector: LoginViewControllerDelegate {
    func check(log: String, pas: String) -> Bool {
        Checker.shared.verify(log: log, pas: pas)
      
    }
    
    
}

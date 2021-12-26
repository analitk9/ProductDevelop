//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Denis Evdokimov on 12/26/21.
//

import Foundation
class CurrentUserService{
    
    var user: User? = nil
    
}
extension CurrentUserService: UserService{
    
    func returnUser(for name: String) -> User? {
        if  name == user?.name {
            return user
        }
        return nil
    }
    
    
}

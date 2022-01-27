//
//  ViewControllerFactory.swift
//  Navigation
//
//  Created by Denis Evdokimov on 1/26/22.
//

import UIKit


enum typeOfController {
    case loginVC
    case feedVC(FeedViewModel)
    case infoVC
    case postVC
    case profileVC(UserService,String)
    case photoVC
}
protocol ViewControllerFactoryProtocol {
    func createController(type: typeOfController)-> UIViewController
}

class ViewControllerFactory: ViewControllerFactoryProtocol{
    func createController(type: typeOfController) -> UIViewController {
        switch type {
        case let .profileVC(userService, name):
            return ProfileViewController(userService: userService, name: name)
            
        case.loginVC:
            return LogInViewController()
            
        case .postVC:
            return PostViewController()
            
        case let .feedVC(model):
            return FeedViewController(model: model)
            
        case.infoVC:
            return InfoViewController()
            
        case .photoVC:
            return PhotosViewController()
        }
    }
    
    
}

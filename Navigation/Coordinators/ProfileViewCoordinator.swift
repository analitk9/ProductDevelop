//
//  ProfileViewCoordinator.swift
//  Navigation
//
//  Created by Denis Evdokimov on 1/24/22.
//

import UIKit
final class ProfileViewCoordinator: Coordinator {
    private let userService = CurrentUserService()
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllerFactoryProtocol
    let name: String
    init(viewControllerFactory: ViewControllerFactoryProtocol, navigationController: UINavigationController, name: String){
        self.viewControllerFactory = viewControllerFactory
        self.navigationController = navigationController
        self.name = name
    }
    
    func start() {
        let profileVC = viewControllerFactory.createController(type: .profileVC(userService, name)) as! ProfileViewController
        profileVC.toPhotoVC = toPhotoVC
        navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    func toPhotoVC(){
        guard let navigationController = navigationController else { return }
        let photoViewCoordinator = PhotoViewCoordinator(navigationController: navigationController, viewControllerFActory: viewControllerFactory)
        photoViewCoordinator.start()
    }
    
    
}

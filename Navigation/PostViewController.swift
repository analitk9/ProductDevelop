//
//  PostViewController.swift
//  Navigation
//
//  Created by Denis Evdokimov on 10/17/21.
//

import UIKit

class PostViewController: UIViewController {
    var curentPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = curentPost {
            title = post.title
           view.backgroundColor = .lightGray
        }
        configureBarButton()
        
    }
    
    func configureBarButton() {
        let infoBarButton = UIBarButtonItem(image: UIImage(systemName: "info"),
                                            style:.plain, target: self,
                                            action: #selector( infoVCModal))
        navigationItem.rightBarButtonItem = infoBarButton
    }
    
    
    @objc func infoVCModal() {
        let vc = InfoViewController()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true, completion: nil)
    }
    
}

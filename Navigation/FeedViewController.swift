//
//  FeedViewController.swift
//  Navigation
//
//  Created by Denis Evdokimov on 10/17/21.
//

import UIKit

class FeedViewController: UIViewController {
    
   // var post: Post
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(){
      //  post = Post(title: "Новая Новость!")
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Feed"
        view.addSubview(stack)
        configureStack()
        
    }

    func configureStack(){
        let _ =  ["Кнопка 1","Кнопка 2"].map { [weak self] txt in
            let but = StatusButton()
            but.configure(with: txt)
            but.addTarget(self, action: #selector(pushToPostVC), for: .touchUpInside)
            self?.stack.addArrangedSubview(but)
        }
    }
    
    override func viewWillLayoutSubviews() {
        setupLayout()
    }
    
    func setupLayout(){
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func configureTabBarItem() {
        
        tabBarItem.title = "Feed"
        tabBarItem.image = UIImage(systemName: "newspaper.circle")
        tabBarItem.selectedImage = UIImage(systemName: "newspaper.circle.fill")
        tabBarItem.tag = 10
        
    }
    
    @objc func pushToPostVC() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
        
    }
}

//
//  FeedViewController.swift
//  Navigation
//
//  Created by Denis Evdokimov on 10/17/21.
//

import UIKit

class FeedViewController: UIViewController {
    
    let passwordCheckerModel = PasswordCheckerModel(password: "pass")
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let passwordTextField: UITextField = {
        let textField = StatusTextField()
        textField.configure(with: "enter word")
        return textField
    }()
    
    let colorCkeckLabel: UILabel = {
        let label = UILabel()
        label.text = "     "
        label.backgroundColor = .gray
        return label
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkWord), name: NSNotification.Name(NSNotification.checkPassword), object: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NSNotification.checkPassword), object: nil)
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
            let but = StatusButton(frame: .zero, title: txt, tintColor: StatusButton.Constans.tintColor)
            but.configure()
            but.onTap = pushToPostVC
            self?.stack.addArrangedSubview(but)
            
        }
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(colorCkeckLabel)
        
        let _ : CustomButton = {
            let but = StatusButton(frame: .zero, title: "Press", tintColor: StatusButton.Constans.tintColor)
            but.configure()
            but.onTap = checkButtonPress
            stack.addArrangedSubview(but)
            return but
        }()
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
    
    func pushToPostVC() {
        let postVC = PostViewController()
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc func checkWord(notification: Notification){
        if let rez = notification.object as? Bool {
            colorCkeckLabel.backgroundColor =  rez ? UIColor.green : UIColor.red
        }
    }
    
    func checkButtonPress(){
        if let text = passwordTextField.text, !text.isEmpty {
            passwordCheckerModel.check(word: text)
        }
    }
    
    
}

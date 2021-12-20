//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Denis Evdokimov on 10/20/21.
//

import UIKit

protocol tapAvatarViewProtocol {
   
    func tapHandler(_ gesture: UITapGestureRecognizer)
}

class ProfileHeaderView: UITableViewHeaderFooterView {
   
    private var statusText: String?
    
    private enum Constans{
        static let padding: CGFloat = 16
        static let avatarViewSideSize: CGFloat = 110
        static let statusButtonHeight: CGFloat = 50
        static let statusTextFieldHeight: CGFloat = 40
        static let statusTextFieldHeightPadding: CGFloat = 34
    }
    
    let statusTextField: UITextField = {
        let field = StatusTextField(frame: .zero)
       
        field.configure()
        return field
    }()
    
    var tapAvatarViewDelegate: tapAvatarViewProtocol?
    
    let profileAvatarView: UIImageView = {
        let rect = CGRect(x: 0, y: 0, width: Constans.avatarViewSideSize, height: Constans.avatarViewSideSize)
        let image = ProfileAvatarView(frame: rect)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.configure()
        return image
    }()
     
    let statusButton: UIButton = {
        let button = StatusButton(frame: .zero)
        button.configure(with: "Show status")
        return button
    }()
    
    let statusTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init( reuseIdentifier: String?) {
        super.init( reuseIdentifier: reuseIdentifier)
    
        statusButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        statusTextField.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        profileAvatarView.addGestureRecognizer(gesture)
        profileAvatarView.isUserInteractionEnabled = true
        
        
        contentView.addSubviews([statusTextLabel, profileNameLabel, profileAvatarView, statusButton, statusTextField])
        contentView.backgroundColor = UIColor(red: 199/255, green: 198/255, blue: 205/255, alpha: 1)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    
    func configureLayout(){
        let profileAvatarViewConstraint: [NSLayoutConstraint] = [
            profileAvatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.padding),
            profileAvatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constans.padding),
            profileAvatarView.widthAnchor.constraint(equalToConstant: Constans.avatarViewSideSize),
            profileAvatarView.heightAnchor.constraint(equalToConstant: Constans.avatarViewSideSize)
        ]
        
        let statusButtonConstraint: [NSLayoutConstraint] = [
            statusButton.heightAnchor.constraint(equalToConstant: Constans.statusButtonHeight),
            statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constans.padding),
            statusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.padding),
            statusButton.topAnchor.constraint(equalTo: profileAvatarView.bottomAnchor, constant: Constans.padding * 2)
        ]
        
        let profileNameLabelConstraint: [NSLayoutConstraint] = [
            profileNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constans.padding)
        ]
        
        let statusTextLabelConstraint: [NSLayoutConstraint] = [
            statusTextLabel.leadingAnchor.constraint(equalTo: profileNameLabel.leadingAnchor)
        ]
        
        let statusTextFieldConstraint: [NSLayoutConstraint] = [
            statusTextField.heightAnchor.constraint(equalToConstant: Constans.statusTextFieldHeight),
            statusTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.padding),
            statusTextField.topAnchor.constraint(equalTo: statusTextLabel.bottomAnchor, constant: Constans.padding),
            statusTextField.leadingAnchor.constraint(equalTo: statusTextLabel.leadingAnchor),
            statusTextField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -Constans.statusTextFieldHeightPadding)
        ]
        
        NSLayoutConstraint.activate( profileAvatarViewConstraint +
                                     statusButtonConstraint +
                                     profileNameLabelConstraint +
                                     statusTextLabelConstraint +
                                     statusTextFieldConstraint)
        
    }
    
    @objc func statusButtonPressed(){
        if let statusText = statusText {
            statusTextLabel.text = statusText
            statusTextField.resignFirstResponder()
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text
       
    }

    @objc func tapAvatar(_ gesture: UITapGestureRecognizer){
        guard let tapDelegate = tapAvatarViewDelegate else { return }
        tapDelegate.tapHandler(gesture)
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}


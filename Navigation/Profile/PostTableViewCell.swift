//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Denis Evdokimov on 11/7/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private enum Constans{
        static let padding: CGFloat = 16
    }
    
    private lazy var titleTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let myLabel = UILabel()
    private let mySeparator = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([titleTextLabel,postImage, descriptionLabel, likeLabel, viewsLabel])
        separate()
    }
    
    override func layoutSubviews() {
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            titleTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: Constans.padding),
            titleTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: Constans.padding),
            titleTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -Constans.padding),
            
            postImage.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor,constant: Constans.padding),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor,constant: Constans.padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  Constans.padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.padding),

            likeLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: Constans.padding),
            likeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: Constans.padding),
            likeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -Constans.padding),

            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constans.padding),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constans.padding),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,constant: -Constans.padding)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleTextLabel.text =  nil
        postImage.image = nil
        likeLabel.text = nil
        viewsLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func configure(_ post: Post) {
        titleTextLabel.text = post.title
        postImage.image = UIImage(named: post.image)
        likeLabel.text = "Likes: \(String(post.likes))"
        viewsLabel.text = "Views: \(String(post.views))"
        descriptionLabel.text = String(post.description)
        layoutSubviews()
    }
    
    func separate(){
        mySeparator.layer.borderColor = UIColor.lightGray.cgColor
        mySeparator.layer.borderWidth = 1.0
        mySeparator.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mySeparator)
        contentView.addSubview(myLabel)
        
        let views = [
            "contentView" : contentView,
            "label" : myLabel,
            "separator" : mySeparator
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat:
                                                            "V:|-[label]-[separator(2)]|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat:
                                                            "H:|[separator]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(allConstraints)
    }
    
}

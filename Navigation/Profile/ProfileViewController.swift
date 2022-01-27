//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Denis Evdokimov on 10/17/21.
//

import UIKit
import iOSIntPackage

class ProfileViewController: UIViewController {
    
    
    fileprivate enum CellReuseID: String {
        case `default` = "TableViewCellReuseIDDefault"
        case sectionHeader = "TableViewHeaderSectionID"
        case photoCell = "PhotoTableViewCellID"
    }

    var name: String
    var userService: UserService

    var profileViewModel: ProfileViewModel
    
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var detailProfileView: DetailProfileAvatar?
    
    init(model: ProfileViewModel, userService: UserService, name: String) {
        
        self.profileViewModel = model
        self.userService = userService
        self.name = name
        
        super.init(nibName: nil, bundle: nil)
        configureTabBarItem()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = tabBarItem.title
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        view.addSubview(tableView)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: CellReuseID.default.rawValue)
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: CellReuseID.sectionHeader.rawValue)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseID.photoCell.rawValue)
        profileViewModel.send(.viewIsReady)
        setupViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        configureLayout()
    }
    
    func configureLayout() {
        [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ].forEach { $0.isActive = true }
    }
    
    func configureTabBarItem() {
        tabBarItem.title = "Profile"
        tabBarItem.image = UIImage(systemName: "person")
        tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        tabBarItem.tag = 20
    }
    
    private func setupViewModel() {
        profileViewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loaded:
                self.tableView.reloadData()
                
            case let .imageFiltered(filteredImage, indexPath):
               let cell = self.tableView.cellForRow(at: indexPath) as! PostTableViewCell
                cell.applyImageFilter(filteredImage)
               
            default:
              print("initial")
            }
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        }else {
            return 0
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return profileViewModel.postModel.count //   postModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let reUseID = CellReuseID.photoCell.rawValue
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reUseID, for: indexPath) as? PhotosTableViewCell else { fatalError() }
            cell.tapHandler = tapArrow
            cell.configure(with: profileViewModel.photoModel.suffix(4))
            return cell
        case 1:
            let reuseID = CellReuseID.default.rawValue
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? PostTableViewCell else { fatalError() }
            let post = profileViewModel.postModel[indexPath.row]
            cell.configure(post)
            
            guard let image = UIImage(named: post.image) else {fatalError()}
            profileViewModel.send(.setupImageFilter(image, indexPath))
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let reuseId = CellReuseID.sectionHeader.rawValue
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                        reuseId) as? ProfileHeaderView else { fatalError() }
            if let currentUser = userService.returnUser(for: name){
                view.profileNameLabel.text = currentUser.name
            }
            view.tapAvatarViewDelegate = self
            return view
        }
        return nil
    }
    
    func tapArrow(){
        profileViewModel.send(.pressButtonToPhotoVC)
    }
    
}

extension ProfileViewController: tapAvatarViewProtocol {
    
    
    func tapHandler(_ gesture: UITapGestureRecognizer) {
        guard let avatarImage = gesture.view else { return }
        avatarImage.isHidden = true
        detailProfileView = DetailProfileAvatar(with: avatarImage, frame: .zero)
        
        guard let showView = detailProfileView else {return}
        showView.frame.size = view.frame.size
        view.addSubview(showView)
        
        showView.profileAvatarView.frame = avatarImage.convert(avatarImage.bounds, to: view)
        showView.startRect = showView.profileAvatarView.frame
        showView.avatarAnimator.startAnimation()
        showView.buttonAnimator.startAnimation(afterDelay: 0.5)
    }
}




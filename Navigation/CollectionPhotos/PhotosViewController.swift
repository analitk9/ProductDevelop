//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Denis Evdokimov on 11/15/21.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    fileprivate enum CellReuseID: String {
        case `default` = "collectionViewCell"
    }
    
    let imagePublisher = ImagePublisherFacade()
    
    var photoModel: [UIImage] = []
    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()
    
    private let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    private let itemsPerRow: CGFloat = 3
    
    deinit {
        imagePublisher.removeSubscription(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePublisher.subscribe(self)
        imagePublisher.addImagesWithTimer(time: 1, repeat: 30)
        navigationItem.title = "Photo Gallery"
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseID.default.rawValue)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        configureLayout()
    }
    
    func configureLayout(){
        [
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
    
}

extension PhotosViewController: UICollectionViewDelegate{
    
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cel = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            CellReuseID.default.rawValue, for: indexPath) as? PhotoCollectionViewCell  else { fatalError()}
        let curImage = photoModel[indexPath.row]
        cel.configure(with: curImage)
        return cel
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 2*sectionInsets.left + (itemsPerRow + 1)*sectionInsets.left
        let availableWidth = UIScreen.main.bounds.width - paddingSpace
        let widthPerItem = round(availableWidth / itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]){
        photoModel = images
        collectionView.reloadData()
    }
}

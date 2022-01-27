//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Denis Evdokimov on 1/27/22.
//

import UIKit
import iOSIntPackage

class ProfileViewModel {
    private(set) var state: ProfileState = .initial {
        didSet {
            onStateChanged?(state) // сюда модель сообщает о изменении своего состояния
        }
    }
    var onStateChanged: ((ProfileState) -> Void)?
    var toPhotoVC: (()-> Void)?
    var postModel: [Post] = [Post]()
    var photoModel: [Photo] = [Photo]()
    let imageProcessor = ImageProcessor()
    private let postsService: Posts
    private let photoService: Photos
    
    init(postsService: Posts, photoService: Photos) {
        self.postsService = postsService
        self.photoService = photoService
    }
    
    func send(_ action: Action){
        switch action {
        case let  .setupImageFilter(image, indexPath):
            applyFilter(to: image, in: indexPath)
            
        case .pressButtonToPhotoVC:
            toPhotoVC?()
            
        case .viewIsReady:
            fetch()
        }
    }
    
    private func fetch(){
        postModel = postsService.createMockData()
        photoModel = photoService.createMockPhotos()
        state = .loaded
    }
    
    func applyFilter(to image: UIImage, in indexPath: IndexPath){
        imageProcessor.processImageAsync(sourceImage:image, filter: ColorFilter.colorInvert) { resultImage in //.allCases.randomElement()!
            guard let resultImage = resultImage else {fatalError()}
            DispatchQueue.main.async { [weak self] in
                let resultImage = UIImage(cgImage: resultImage)
                self?.state = .imageFiltered(resultImage, indexPath)
            }
        }
    }
    
}

extension ProfileViewModel {
    
    enum Action { //  состояния вью
        case viewIsReady
        case pressButtonToPhotoVC
        case setupImageFilter(UIImage, IndexPath)
    }
    
    enum ProfileState { // состояния модели
        
        case initial
        case imageFiltered(UIImage, IndexPath)
        case loaded
        
    }
}

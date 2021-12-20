//
//  ExtentionUIView.swift
//  Navigation
//
//  Created by Denis Evdokimov on 11/3/21.
//

import UIKit

extension UIImage{
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { _ in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

extension UITextField {
    
    func indent(size:CGFloat) {
        let rect = CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height)
        self.leftView = UIView(frame: rect)
        self.leftViewMode = .always
    }
    
}

extension UIView {
    func addSubviews(_ views: [UIView]){
        views.forEach { addSubview($0)}
    }
    
}




     

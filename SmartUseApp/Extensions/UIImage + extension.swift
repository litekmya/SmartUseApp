//
//  UIImage + extension.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 10.06.2022.
//

import UIKit

extension UIImage {
    
    func resize(image: UIImage, scaledTo newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1)
        
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        guard let scaledImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage()}
        
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    func getImage(from data: Data?) -> UIImage {
        guard let imageData = data else { return UIImage() } // Заменить на загрушку
        guard let image = UIImage(data: imageData) else { return UIImage() }
        return image
    }
    
}

//
//  ImageManager.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/22.
//

import UIKit

final class ImageManager {
    
    func image(urlString: String, completionHandler: @escaping (ImagePair) -> Void) {
        if let image = imageCache.object(forKey: urlString as NSString) {
            let imagePair = ImagePair(key: urlString, image: image)
            completionHandler(imagePair)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        session.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil else { return }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            guard let data = data,
                  let image = UIImage(data: data) else {
                return
            }
            
            self?.imageCache.setObject(image, forKey: urlString as NSString)
            let imagePair = ImagePair(key: urlString, image: image)
            completionHandler(imagePair)
        }
        .resume()
    }
    
    //MARK: - Private
    private var imageCache = NSCache<NSString, UIImage>()
    private let session = URLSession.shared
}

typealias ImagePair = (key: String, image: UIImage)

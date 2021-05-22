//
//  ImageCollectionViewCell.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/22.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
}

extension ImageCollectionViewCell {
    static let identifier = "imageCollectionViewCell"
}

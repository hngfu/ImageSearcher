//
//  ImageCollectionViewCell.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/22.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageKey = String()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageKey = String()
    }
}

extension ImageCollectionViewCell {
    static let identifier = "imageCollectionViewCell"
}

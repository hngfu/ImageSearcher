//
//  SearchedImageInfo.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/24.
//

import Foundation

struct SearchedImageInfo: Decodable {
    
    let thumbnailURL: String
    let imageURL: String
    let siteName: String
    let dateTime: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
        case siteName = "display_sitename"
        case dateTime = "datetime"
        case width = "width"
        case height = "height"
    }
}

//
//  SearchedImageInfo.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/22.
//

import Foundation

struct SearchedImageResults: Decodable {
    
    let documents: [SearchedImageInfo]
    let meta: Meta
    
    struct Meta: Decodable {
        let isEnd: Bool
    }
}

struct SearchedImageInfo: Decodable {
    
    let thumbnailURL: String
    let imageURL: String
    let siteName: String
    let dateTime: String
    
    enum CodingKeys: String, CodingKey {
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
        case siteName = "display_sitename"
        case dateTime = "datetime"
    }
}

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
        
        enum CodingKeys: String, CodingKey {
            case isEnd = "is_end"
        }
    }
}

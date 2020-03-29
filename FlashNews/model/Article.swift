//
//  Article.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 29/03/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

class Article : Decodable {
    let title : String
    let url : String
    let imageUrl : String
    let publishedAt : String
   
    enum CodingKeys: String, CodingKey {
        case title
        case url
        case imageUrl = "urlToImage"
        case publishedAt
    }
    
}

//
//  Article.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 19/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

struct Article: Codable {
    let source: Source
    let title : String
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case title
        case articleDescription = "description"
        case url, urlToImage, publishedAt
    }
    
    // MARK: - Source
    struct Source: Codable {
        let id : String?
        let name: String
    }

}


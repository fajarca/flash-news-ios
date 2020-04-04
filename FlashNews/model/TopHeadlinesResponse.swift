//
//  TopHeadlinesResponse.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 29/03/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

// MARK: - TopHeadlinesResponse
struct TopHeadlinesResponse: Codable {
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case title
        case articleDescription = "description"
        case url, urlToImage, publishedAt
    }
}

// MARK: - Source
struct Source: Codable {
    let id : String?
    let name: String
}

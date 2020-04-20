//
//  SearchResults.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 20/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

// MARK: - SearchResultResponse
struct SearchResultResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [SearchResult]
}

// MARK: - Article
struct SearchResult: Codable {
    let source: SearchResultSource
    let author, title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct SearchResultSource: Codable {
    let id: String
    let name: String
}

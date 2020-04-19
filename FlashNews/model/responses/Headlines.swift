//
//  TopHeadlinesResponse.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 29/03/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

// MARK: - TopHeadlinesResponse
public struct TopHeadlinesResponse: Codable {
    public let articles: [Article]
}

// MARK: - Article
public struct Article: Codable {
    public let source: Source
    public let title : String
    public let articleDescription: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case title
        case articleDescription = "description"
        case url, urlToImage, publishedAt
    }
}

// MARK: - Source
public struct Source: Codable {
    public let id : String?
    public let name: String
}

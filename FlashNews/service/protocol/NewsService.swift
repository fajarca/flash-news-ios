//
//  NewsService.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 19/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

protocol NewsService {
    
    func fetchNews(successHandler: @escaping (_ response: TopHeadlinesResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    
    func searchNews(query : String, successHandler: @escaping (_ response: TopHeadlinesResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    
}

public enum NewsError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}

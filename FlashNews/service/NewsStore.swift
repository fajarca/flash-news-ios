//
//  NewsStore.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 19/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

class NewsStore : NewsService {
    
    private init() {}
    public static let shared = NewsStore()
    private let baseUrl = "https://newsapi.org/v2/"
    private let apiKey = "c7acc244e5884787b21010cd475495cb"
    private let urlSession = URLSession.shared
    
    func fetchNews(successHandler: @escaping (TopHeadlinesResponse) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        
        let url = "\(baseUrl)/top-headlines"
        guard var urlComponent = URLComponents(string : url) else {
            errorHandler(NewsError.invalidEndpoint)
            return 
        }
        
        let queries =  [URLQueryItem(name: "country", value: "id")]
        urlComponent.queryItems = queries
        
        guard let componentUrl = urlComponent.url else {
            errorHandler(NewsError.invalidEndpoint)
            return
        }
        
        var request = URLRequest(url: componentUrl)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        urlSession.dataTask(with: request) { (data, response, error) in
               if error != nil {
                   self.handleError(errorHandler: errorHandler, error: NewsError.apiError)
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                   self.handleError(errorHandler: errorHandler, error: NewsError.invalidResponse)
                   return
               }
               
               guard let data = data else {
                   self.handleError(errorHandler: errorHandler, error: NewsError.noData)
                   return
               }
               
               do {
                   let result = try JSONDecoder().decode(TopHeadlinesResponse.self, from: data)
                   DispatchQueue.main.async {
                       successHandler(result)
                   }
               } catch {
                   self.handleError(errorHandler: errorHandler, error: NewsError.serializationError)
               }
           }.resume()
    }
    
    
    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
         DispatchQueue.main.async {
             errorHandler(error)
         }
     }
}

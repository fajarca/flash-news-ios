//
//  ApiService.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 11/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

enum ApiError {
    case HttpError
    case UnkownError
    case NoData
    case ParsingError
}

protocol ApiServiceProtocol {
    func getHeadlines(onComplete : @escaping (_ response : TopHeadlinesResponse?, _ errorMessage : String?) -> Void)
}

class ApiService: ApiServiceProtocol {
    func getHeadlines(onComplete: @escaping (TopHeadlinesResponse?, String?) -> Void) {
        
        let session = URLSession.shared
        
        var urlComponent = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
        urlComponent.queryItems = [URLQueryItem(name: "country", value: "id")]
        
        var request = URLRequest(url: urlComponent.url!)
        request.addValue("c7acc244e5884787b21010cd475495cb", forHTTPHeaderField: "Authorization")
        
        
        session.dataTask(with: request) { (data, response, error) in
            
            // Make sure the error is nil
            guard error == nil else {
                print("Error \(error)")
                onComplete(nil, error?.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)  else {
                onComplete(nil, "HTTP \((response as? HTTPURLResponse)?.statusCode)")
                return
            }
            
            // Check that data is non null
            guard let content = data else {
                onComplete(nil, "No data")
                return
            }
            
           
            //Decode
            do {
                let result = try JSONDecoder().decode(TopHeadlinesResponse.self, from: content)
                onComplete(result, nil)
               
                
            } catch let error {
                onComplete(nil, "Parsing error : \(error.localizedDescription)")
            }
            
            
            
        }.resume()
    }
}

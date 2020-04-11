//
//  HomeViewModel.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 10/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    var updateLoadingStatus: (()-> Void)?
    var refreshTableView: (()-> Void)?
    
    
    var isLoading : Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var news : [NewsArticle] = [] {
        didSet {
            self.refreshTableView?()
            print("Updated news")
        }
    }

    func map(articles : [Article]) -> [NewsArticle]  {
        var news = [NewsArticle]()
        for i in articles {
            news.append(NewsArticle(sourceName: i.source.name, title: i.title, url: mapUrl(url: i.url), imageUrl: mapImageUrl(imageUrl: i.urlToImage), publishedAt: mapDate(isoDate: i.publishedAt)))
        }
        return news
    }
    
    func getNews() {
        isLoading = true
        let session = URLSession.shared
        
        var urlComponent = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
        urlComponent.queryItems = [URLQueryItem(name: "country", value: "id")]
        
        var request = URLRequest(url: urlComponent.url!)
        request.addValue("c7acc244e5884787b21010cd475495cb", forHTTPHeaderField: "Authorization")
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // Make sure the error is nil
            guard error == nil else {
                print("Error \(error)")
                return
            }
            
            guard let httpRespnse = response as? HTTPURLResponse else { return }
            let httpCode = httpRespnse.statusCode
            
            
            // Check that data is non null
            guard let content = data else {
                print("Error", "No data")
                return
            }
            
           
            //Decode
            do {
                let result = try JSONDecoder().decode(TopHeadlinesResponse.self, from: content)
                let news = self.map(articles: result.articles)
                self.news = news
                
            } catch let error {
                print("Error when parsing : ", error.localizedDescription)
            }
            
            self.isLoading = false
            
        }
        task.resume()
    }
    
    func getCellViewModel(at indexPath : IndexPath) -> NewsArticle {
        return news[indexPath.row]
    }
    
}

extension HomeViewModel {
     func mapUrl(url : String?) -> String {
        guard let url = url else { return "-" }
        return url
    }
     func mapImageUrl(imageUrl : String?) -> String {
        guard let imageUrl = imageUrl else { return "-" }
        return imageUrl
    }
     func mapDate(isoDate : String?) -> String {
        guard let isoDate = isoDate else { return "-" }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.dateFormat = "HH:mm"
        let output = dateFormatter.string(from: date)
        return output
    }
}

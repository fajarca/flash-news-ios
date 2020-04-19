//
//  NewsArticle.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 10/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

struct HeadlineViewViewModel {
    private var article : Article
    
    init(article : Article) {
        self.article = article
    }
    
    var source : String {
        return article.source.name
    }
    var title : String {
        return article.title
    }
    var url : String {
        return article.url ?? "-"
    }
    var imageUrl : URL {
        if let url = article.urlToImage {
            return URL(string : url)!
        }
        return URL(string : "")!
    }
    var publishedAt : String {
        return mapDate(isoDate: article.publishedAt)
    }
    
    
    private func mapDate(isoDate : String?) -> String {
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

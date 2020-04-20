//
//  SearchResultViewViewModel.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 20/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation


struct SearchResultViewViewModel {
    private var result : Article
    
    init(result : Article) {
        self.result = result
    }
    
    var source : String {
        return result.source.name
    }
    var title : String {
        return result.title ?? "-"
    }
    var url : String {
        return result.url ?? "-"
    }
    var imageUrl : URL? {
        if let url = result.urlToImage {
            return URL(string : url)!
        }
        return URL(string : "")
    }
    var publishedAt : String {
        return mapDate(isoDate: result.publishedAt)
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

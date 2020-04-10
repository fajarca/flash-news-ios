//
//  HomeViewModel.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 10/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation

struct HomeViewModel {
    
    let articles : [Article]
    private(set) var sourceName = ""
    private(set) var title = ""
    private(set) var url = ""
    private(set) var imageUrl = ""
    private(set) var publishedAt = ""
    
    
    init(articles : [Article]) {
        self.articles = articles
        updateProperties()
    }
    
    private mutating func updateProperties() {
        publishedAt = mapDate(isoDate: articles[0].publishedAt ?? "")
    }
    
}

extension HomeViewModel {
    private func mapDate(isoDate : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        dateFormatter.dateFormat = "HH:mm"
        let output = dateFormatter.string(from: date)
        return output
    }
}

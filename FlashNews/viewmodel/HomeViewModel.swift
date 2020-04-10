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
        publishedAt = mapDate(date: articles[0].publishedAt ?? "")
    }
    
}

extension HomeViewModel {
    private func mapDate(date : String) -> String {
        return "Jumat, 10 April 2018 14:00"
    }
}

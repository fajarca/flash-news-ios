//
//  HomeViewModel.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 10/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    private let mapper = NewsPresentationMapper()
    let headlines = PublishSubject<[NewsArticle]>()
    let isLoading = PublishSubject<Bool>()
  
    func getNews() {
        isLoading.onNext(true)
        ApiService().getHeadlines { (response, errorMessage) in
            if let response = response {
                self.isLoading.onNext(false)
                let headlines = self.mapper.map(articles: response.articles)
                self.headlines.onNext(headlines)
            }
        }
    }
    
}

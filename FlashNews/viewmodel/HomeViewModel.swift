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
    
    let articles = PublishSubject<[Article]>()
    let isLoading = PublishSubject<Bool>()
  
    func getNews() {
        isLoading.onNext(true)
        ApiService().getHeadlines { (response, errorMessage) in
            if let response = response {
                self.isLoading.onNext(false)
                self.articles.onNext(response.articles)
            }
        }
    }
    
}

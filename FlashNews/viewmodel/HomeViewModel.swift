//
//  HomeViewModel.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 10/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    private let newsService : NewsService
    private let _articles = BehaviorRelay<[Article]>(value: [])
    private let _isLoading = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    init(service newsService : NewsService) {
        self.newsService = newsService
    }
    
    
    var isLoading : Driver<Bool> {
        return _isLoading.asDriver()
    }
    
    var error : Driver<String?> {
        return _error.asDriver()
    }
    
    var articles : Driver<[Article]> {
        return _articles.asDriver()
    }
    
    var hasError : Bool {
        return _error.value != nil
    }
    
    var numberOfHeadlines : Int {
        return _articles.value.count
    }
    
    func viewModelForHeadline(at index : Int) -> HeadlineViewViewModel? {
        guard index < _articles.value.count else {
            return nil
        }
        return HeadlineViewViewModel(article: _articles.value[index])
    }
    
    func getNews() {
        self._articles.accept([])
        self._isLoading.accept(true)
        self._error.accept(nil)
        
        newsService.fetchNews(successHandler: { [weak self] (response) in
            self?._isLoading.accept(false)
            self?._articles.accept(response.articles)
        }) { [weak self] (error) in
            self?._isLoading.accept(false)
            self?._error.accept(error.localizedDescription)
        }
        
    }
    
    
}

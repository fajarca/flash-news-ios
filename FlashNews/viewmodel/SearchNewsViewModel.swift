//
//  SearchNewsViewModel.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 20/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchNewsViewModel {

   private let disposeBag = DisposeBag()
   private let newsService : NewsService
   private let _searchResults = BehaviorRelay<[Article]>(value: [])
   private let _isLoading = BehaviorRelay<Bool>(value: false)
   private let _error = BehaviorRelay<String?>(value: nil)
   
    init(query : Driver<String>, service newsService : NewsService) {
       self.newsService = newsService
        query
            .throttle(1.5)
            .distinctUntilChanged()
            .filter{!$0.isEmpty}
            .drive(onNext :  { [weak self] query in
                self?.searchNews(searchFor: query)
            }).disposed(by: disposeBag)
   }
   
   
   var isLoading : Driver<Bool> {
       return _isLoading.asDriver()
   }
   
   var error : Driver<String?> {
       return _error.asDriver()
   }
   
   var searchResults : Driver<[Article]> {
       return _searchResults.asDriver()
   }
   
   var hasError : Bool {
       return _error.value != nil
   }
   
   var numberOfResult : Int {
       return _searchResults.value.count
   }
   
   func viewModelForSearchResult(at index : Int) -> SearchResultViewViewModel? {
       guard index < _searchResults.value.count else {
           return nil
       }
       return SearchResultViewViewModel(result: _searchResults.value[index])
   }
   
    func searchNews(searchFor query : String) {
       self._searchResults.accept([])
       self._isLoading.accept(true)
       self._error.accept(nil)
       
        newsService.searchNews(query : query, successHandler: { [weak self] (response) in
           self?._isLoading.accept(false)
            self?._searchResults.accept(response.articles)
       }) { [weak self] (error) in
           self?._isLoading.accept(false)
           self?._error.accept(error.localizedDescription)
       }
       
   }
   

}

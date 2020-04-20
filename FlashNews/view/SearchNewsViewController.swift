//
//  SearchNewsViewController.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 19/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift

class SearchNewsViewController: UIViewController {
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    private var viewModel : SearchNewsViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupViewModel()
        setupTableView()
        observeLoadingState()
        observeHeadlines()
        observeError()
    }
    
    private func setupSearchBar() {
         navigationItem.searchController = UISearchController(searchResultsController: nil)
         self.definesPresentationContext = true
         navigationItem.searchController?.dimsBackgroundDuringPresentation = false
         navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
         
         navigationItem.searchController?.searchBar.sizeToFit()
         navigationItem.hidesSearchBarWhenScrolling = true
         navigationController?.navigationBar.prefersLargeTitles = true
         
     }
    
    private func setupViewModel() {
        let searchBar = navigationItem.searchController!.searchBar
        viewModel = SearchNewsViewModel(query: searchBar.rx.text.orEmpty.asDriver(), service: NewsStore.shared)
    }
    
    private func observeLoadingState() {
        viewModel
            .isLoading
            .drive(onNext: { [unowned self] (isLoading) in
                if isLoading {
                    self.startActivityIndicator()
                    self.searchResultTableView.alpha = 0.0
                } else {
                    self.stopActivityIndicator()
                    self.searchResultTableView.alpha = 1.0
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func observeHeadlines() {
        viewModel
            .searchResults
            .drive(onNext : { [unowned self] _ in
                self.searchResultTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func observeError() {
        viewModel
            .error
            .drive(onNext : { [unowned self] errorMessage in
                
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        searchResultTableView.dataSource = self
        searchResultTableView.tableFooterView = UIView()
        searchResultTableView.rowHeight = UITableView.automaticDimension
        searchResultTableView.estimatedRowHeight = 180
    }
    
    private func startActivityIndicator() {
        progressIndicator.startAnimating()
    }
    private func stopActivityIndicator() {
        progressIndicator.stopAnimating()
    }
    
 
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SearchNewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfResult
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultTableViewCell
        
        
        if let result = viewModel.viewModelForSearchResult(at: indexPath.row) {
            cell.configure(viewModel: result)
        }
        
        return cell
        
    }
    
    
}

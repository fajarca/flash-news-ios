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
    
    private var viewModel = SearchNewsViewModel(service: NewsStore.shared)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        observeLoadingState()
        observeHeadlines()
        observeError()
        viewModel.searchNews(searchFor: "iphone")
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
                print("Error \(errorMessage)")
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        searchResultTableView.dataSource = self
    }
    
    private func startActivityIndicator() {
        progressIndicator.startAnimating()
    }
    private func stopActivityIndicator() {
        progressIndicator.stopAnimating()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
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

extension SearchNewsViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Type \(searchText)")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Press enter with query \(searchBar.text)")
    }
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

//
//  HomeViewController.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 29/03/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = HomeViewModel(service: NewsStore.shared)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getNews()
        observeLoadingState()
        observeHeadlines()
        observeError()
    }
    
    private func observeLoadingState() {
        viewModel
            .isLoading
            .drive(onNext: { [unowned self] (isLoading) in
                if isLoading {
                    self.startActivityIndicator()
                    self.tableView.alpha = 0.0
                } else {
                    self.stopActivityIndicator()
                    self.tableView.alpha = 1.0
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func observeHeadlines() {
        viewModel
            .articles
            .drive(onNext : { [unowned self] _ in
                self.tableView.reloadData()
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
        tableView.dataSource = self
    }
    
    private func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    private func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newsDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destination as? NewsDetailViewController
                
                if let headline = viewModel.viewModelForHeadline(at: indexPath.row) {
                      destinationViewController?.newsUrl = headline.url
                      destinationViewController?.newsTitle = headline.title
                }
            }
        }
        
    }
    
}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfHeadlines
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopHeadlineTableViewCell
        
        
        if let headline = viewModel.viewModelForHeadline(at: indexPath.row) {
            cell.configure(viewModel: headline)
        }
    
        return cell
        
    }
    
    
}

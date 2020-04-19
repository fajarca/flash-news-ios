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
    
    private var viewModel : HomeViewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getNews()
        observeLoadingState()
        observeHeadlines()
    }
    
    private func observeLoadingState() {
        viewModel
            .isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (isLoading) in
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
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (headlines) in
                self.articles = headlines
                self.tableView.reloadData()
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
                let article = articles[indexPath.row]
                let viewModel = HeadlineViewViewModel(article: article)
                destinationViewController?.newsUrl = viewModel.url
                destinationViewController?.newsTitle = viewModel.title
            }
        }
        
    }
    
}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopHeadlineTableViewCell
        
        
        let article = articles[indexPath.row]
        
        let viewModel = HeadlineViewViewModel(article: article)
        cell.configure(viewModel: viewModel)
        
        return cell
        
    }
    
    
}

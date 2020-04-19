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
    private var headlines = [NewsArticle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getNews()
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
            .headlines
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (headlines) in
                self.headlines = headlines
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
                let article = viewModel.getCellViewModel(at: indexPath)
                destinationViewController?.newsUrl = article.url
                destinationViewController?.newsTitle = article.title
            }
        }
        
    }
    
}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopHeadlineTableViewCell
        
        
        let article = headlines[indexPath.row]
        
        cell.headlineTitleLabel.text = article.title
        cell.headlineSourceLabel.text = article.sourceName
        cell.headlineTimestamp.text = article.publishedAt
        cell.headlineImageView.sd_setImage(with: URL(string: article.imageUrl), completed: nil)
        
        
        return cell
        
    }
    
    
}

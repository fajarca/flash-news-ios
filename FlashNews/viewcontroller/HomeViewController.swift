//
//  HomeViewController.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 29/03/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getNews()
        
    }
    
    private func getNews() {
        startActivityIndicator()
        let url = URL(string: "https://newsapi.org/v2/top-headlines")
        let parameters = ["country" : "id"]
        
        let headers : HTTPHeaders = [
            .authorization("c7acc244e5884787b21010cd475495cb"),
            .accept("application/json")
        ]
        
        let request = AF.request(url!, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: headers, interceptor: nil)
        
        
        request.responseDecodable(of: TopHeadlinesResponse.self) { (response) in
            switch response.result {
            case let .success(result) :
                self.articles = result.articles
                self.tableView.reloadData()
                self.stopActivityIndicator()
            case let .failure(error) :
                print(error)
                self.stopActivityIndicator()
            }
            
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
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
                destinationViewController?.newsUrl = article.url ?? ""
                destinationViewController?.newsTitle = article.title
            }
        }
        
    }
    
}


extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TopHeadlineTableViewCell
        
        let article = articles[indexPath.row]
        let image = article.urlToImage ?? ""
        let imageUrl = URL(string: image)
        
        cell.headlineTitleLabel.text = article.title
        cell.headlineImageView.sd_setImage(with: imageUrl, completed: nil)
        cell.headlineSourceLabel.text = article.source.name
        
        return cell
        
    }
    
    
}

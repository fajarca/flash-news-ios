//
//  HomeViewController.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 29/03/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import UIKit
import SDWebImage


class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var viewModel : HomeViewModel?
    private var articles = [Article]() {
        didSet {
            viewModel = HomeViewModel(articles: articles)
            print("Did set executed")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        getNews()
    }
    
    
    
    private func getNews() {
        let session = URLSession.shared
        
        var urlComponent = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
        urlComponent.queryItems = [URLQueryItem(name: "country", value: "id")]
        
        var request = URLRequest(url: urlComponent.url!)
        request.addValue("c7acc244e5884787b21010cd475495cb", forHTTPHeaderField: "Authorization")
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // Check for errors
            guard error == nil else {
                print("Error", error)
                return
            }
            
            guard let httpRespnse = response as? HTTPURLResponse else { return }
            let httpCode = httpRespnse.statusCode
            
            
            // Check that data is non null
            guard let content = data else {
                print("Error", "No data")
                return
            }
            
           
            //Decode
            do {
                let result = try JSONDecoder().decode(TopHeadlinesResponse.self, from: content)
                
                DispatchQueue.main.async {
                    self.articles = result.articles
                    self.tableView.reloadData()
                    self.stopActivityIndicator()
                }
                
            } catch let error {
                print("Error when parsing : ", error.localizedDescription)
            }
            
        }
        task.resume()
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
        cell.headlineTimestamp.text = viewModel?.publishedAt
        
        return cell
        
    }
    
    
}

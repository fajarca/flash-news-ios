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

    @IBOutlet weak var tableView: UITableView!
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getNews()
        
    }

    private func getNews() {
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
                guard let articles = response.value else { return }
                                print(response)
                self.articles = articles.articles
                                self.tableView.reloadData()
            case let .failure(error) :
                print(error)
            }
                
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newsDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destination as? NewsDetailViewController
                destinationViewController?.newsUrl = articles[indexPath.row].url
                destinationViewController?.newsTitle = articles[indexPath.row].title
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
        let imageUrl = URL(string: article.urlToImage)
        
        cell.headlineTitleLabel.text = article.title
        cell.headlineImageView.sd_setImage(with: imageUrl, completed: nil)
        cell.headlineSourceLabel.text = article.source.name
        
        return cell
        
    }
    
    
}

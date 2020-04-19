//
//  SearchNewsViewController.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 19/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import UIKit

class SearchNewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
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
    
}

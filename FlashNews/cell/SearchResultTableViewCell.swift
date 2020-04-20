//
//  SearchResultTableViewCell.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 20/04/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import UIKit
import UIKit
import SDWebImage

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
   
  func configure(viewModel : SearchResultViewViewModel) {
        sourceNameLabel.text = viewModel.source
        titleLabel.text = viewModel.title
        photoImageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
        timestampLabel.text = viewModel.publishedAt
    }

}

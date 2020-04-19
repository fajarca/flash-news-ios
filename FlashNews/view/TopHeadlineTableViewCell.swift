//
//  TopHeadlineCell.swift
//  FlashNews
//
//  Created by Fajar Chaeril Azhar on 29/03/20.
//  Copyright © 2020 Fajar Chaeril Azhar. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class TopHeadlineTableViewCell : UITableViewCell {
    @IBOutlet weak var headlineSourceLabel: UILabel!
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineTimestamp: UILabel!
    
    func configure(viewModel : HeadlineViewViewModel) {
        headlineSourceLabel.text = viewModel.source
        headlineTitleLabel.text = viewModel.title
        headlineImageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
        headlineTimestamp.text = viewModel.publishedAt
    }
}

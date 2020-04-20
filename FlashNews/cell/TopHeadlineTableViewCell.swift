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
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    
    func configure(viewModel : HeadlineViewViewModel) {
        sourceNameLabel.text = viewModel.source
        titleLabel.text = viewModel.title
        photoImageView.sd_setImage(with: viewModel.imageUrl, completed: nil)
        timestampLabel.text = viewModel.publishedAt
    }
}

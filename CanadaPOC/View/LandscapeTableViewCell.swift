//
//  LandscapeTableViewCell.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class LandscapeTableViewCell: UITableViewCell {
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    var feedsValue : ListModel? {
        didSet {
            guard let feeds = feedsValue else {
                return
            }
            titleLabel?.text = feeds.title
            descriptionLabel?.text = feeds.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbnailImage.contentMode =   .scaleAspectFit
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


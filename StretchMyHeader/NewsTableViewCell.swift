//
//  NewsTableViewCell.swift
//  StretchMyHeader
//
//  Created by Jimmy Hoang on 2017-07-04.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

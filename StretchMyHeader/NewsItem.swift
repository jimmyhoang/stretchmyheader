//
//  NewsItem.swift
//  StretchMyHeader
//
//  Created by Jimmy Hoang on 2017-07-04.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

import Foundation
import UIKit

struct NewsItem {
    var category:String
    var description:String
    var colour:UIColor
    
    init(category:String,description:String,colour:UIColor) {
        self.category = category
        self.description = description
        self.colour = colour
    }
}

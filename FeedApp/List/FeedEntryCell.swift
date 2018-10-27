//
//  Response.swift
//  FeedApp
//
//  Created by Damian Rzeszot on 27/10/2018.
//  Copyright © 2018 Damian Rzeszot. All rights reserved.
//

import UIKit

class FeedEntryCell: UITableViewCell {

    @IBOutlet private var contentLabel: UILabel!

    func configure(content: String) {
        contentLabel.text = content
    }
}

//
//  chatTableViewCell.swift
//  pchatapp
//
//  Created by Cory Barton on 8/28/18.
//  Copyright © 2018 Cory Barton. All rights reserved.
//

import UIKit

class chatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

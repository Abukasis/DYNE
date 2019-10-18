//
//  MyCell.swift
//  TinderStack
//
//  Created by Oliver on 9/20/19.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  CompletedItemsInBundleTableViewCell.swift
//  Bundle
//
//  Created by Pei Qin on 2018/8/1.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class CompletedItemsInBundleTableViewCell: UITableViewCell {

    @IBOutlet weak var timeTag: UILabel!
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

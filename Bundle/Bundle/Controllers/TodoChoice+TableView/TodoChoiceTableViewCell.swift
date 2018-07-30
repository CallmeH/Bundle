//
//  TodoChoiceTableViewCell.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/25.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class TodoChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var todoForEvent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
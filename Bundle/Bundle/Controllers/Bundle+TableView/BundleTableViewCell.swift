//
//  BundleTableViewCell.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/30.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class BundleTableViewCell: UITableViewCell {

    @IBOutlet weak var todoForBundle: UILabel!
    @IBAction func putBack(_ sender: UIButton) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

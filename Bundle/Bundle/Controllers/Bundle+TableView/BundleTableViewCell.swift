//
//  BundleTableViewCell.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/30.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class BundleTableViewCell: UITableViewCell {

    @IBOutlet weak var todoForBundle: UILabel!
    @IBAction func putBack(_ sender: UIButton) {
        
    }
    
    var onButtonTouched: ((UITableViewCell)->Void)? = nil
    
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        onButtonTouched?(self)
//        if sender.isSelected {
//            sender.isSelected = false
//            print("deselected")
//        } else {
//            sender.isSelected = true
//            print("selected")
//        }
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

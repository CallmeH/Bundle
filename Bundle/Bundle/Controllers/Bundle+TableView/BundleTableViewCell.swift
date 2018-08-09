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
    
    var putBackTouched: ((UITableViewCell)->Void)? = nil
    
    @IBAction func putBack(_ sender: UIButton) {
        putBackTouched?(self)
    }
    
    var onButtonTouched: ((UITableViewCell)->Void)? = nil
    
    @IBOutlet weak var checkButton: UIButton!
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        onButtonTouched?(self)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

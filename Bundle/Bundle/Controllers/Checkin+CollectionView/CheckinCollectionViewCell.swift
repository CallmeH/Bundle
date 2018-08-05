//
//  CheckinCollectionViewCell.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/27.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class CheckinCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventTagCheckin: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected == true {
                self.backgroundColor = UIColor.cyan
            } else {
                self.backgroundColor = UIColor.lightGray
            }
        }
    }
}

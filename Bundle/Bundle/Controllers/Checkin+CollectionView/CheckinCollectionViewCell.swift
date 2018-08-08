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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.eventTagCheckin.frame.width > 0.9 * 0.95 * UIScreen.main.bounds.width {
            self.eventTagCheckin.numberOfLines = Int(self.eventTagCheckin.frame.width/(0.9 * 0.95 * UIScreen.main.bounds.width) + 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected == true {
                self.backgroundColor = UIColor.SummerSkyBlue
                self.eventTagCheckin.textColor = UIColor.AlmostWhite
            } else {
                self.backgroundColor = UIColor.lightGray
                self.eventTagCheckin.textColor = UIColor.BlueGrey
            }
        }
    }
}

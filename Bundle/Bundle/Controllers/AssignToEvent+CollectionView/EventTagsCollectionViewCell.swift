//
//  EventTagsCollectionViewCell.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/26.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class EventTagsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventTag: UILabel!
//    @IBOutlet weak var eventTagMax: NSLayoutConstraint!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
        // Initialization code
//        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
//        self.eventTag.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
//        self.layer.cornerRadius = 4
//        self.eventTagMax.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2
        
//    }

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

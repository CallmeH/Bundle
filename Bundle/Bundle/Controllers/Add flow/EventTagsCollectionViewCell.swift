//
//  EventTagsCollectionViewCell.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/26.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class EventTagsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventTag: UILabel!
//    @IBOutlet weak var eventTagMax: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if self.eventTag.frame.width > 0.9 * 0.95 * UIScreen.main.bounds.width {
            self.eventTag.numberOfLines = Int(self.eventTag.frame.width/(0.9 * 0.95 * UIScreen.main.bounds.width) + 1)
        }
    }

    override var isSelected: Bool {
        didSet {
            if self.isSelected == true {
                self.backgroundColor = UIColor.LightGrey
                self.eventTag.textColor = UIColor.DarkGrey
            } else {
                self.backgroundColor = UIColor.DarkGrey
                self.eventTag.textColor = UIColor.LightGrey
            }
        }
    }
}

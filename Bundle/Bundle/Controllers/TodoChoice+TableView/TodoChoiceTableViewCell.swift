//
//  TodoChoiceTableViewCell.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/25.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class TodoChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var todoTagDisplay: UILabel!
    @IBOutlet weak var todoForEvent: UILabel!
    @IBOutlet weak var repeatDisplay: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var repeatButtonTouched: ((UITableViewCell)->Void)? = nil
    
    @IBAction func editRepeatStatusTapped(_ sender: UIButton) {
        repeatButtonTouched?(self)
    }
    

}

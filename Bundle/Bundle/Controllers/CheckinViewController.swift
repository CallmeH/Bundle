//
//  CheckinViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class CheckinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // before/when/after
    @IBOutlet weak var prepositionDisplayLabel: UILabel!
    //    var prepositionStatus: String = prepType.when.displayName
    var prepositionStatus: prepType = .before
    //    var prepositionStatus: String? = nil
    @IBOutlet weak var prepositionChoice: UISegmentedControl!
    @IBAction func prepositionTapped(_ sender: UISegmentedControl) {
        switch prepositionChoice.selectedSegmentIndex {
        case 0:
            prepositionStatus = .before
            self.prepositionDisplayLabel.text = "I'm about to..."
        case 1:
            prepositionStatus = .when
            self.prepositionDisplayLabel.text = "I'm onto..."
        case 2:
            prepositionStatus = .after
            self.prepositionDisplayLabel.text = "I just finished..."
        default:
            print("no change")
        }
    }
    
    @IBAction func unwindToCheckin(_ segue: UIStoryboardSegue) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

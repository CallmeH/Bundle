//
//  ReviewBundlesViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/31.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class ReviewBundlesViewController: UIViewController {
    @IBOutlet weak var temporaryDisplayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bundles = CoreDataHelper.retrieveAllBundle()
        print(bundles)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  BundleNamingPromtViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/8/5.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class BundleNamingPromtViewController: UIViewController {

    @IBOutlet weak var gobackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if gobackButton != nil {
            self.gobackButton.layer.cornerRadius=8
        }
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    @IBAction func closePopupButton(_ sender: UIButton) {
        self.removeAnimate()
        self.view.removeFromSuperview()
    }

    @IBAction func closePopupAndButton(_ sender: UIButton) {
        self.removeAnimate()
        self.view.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
    }
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{(finished: Bool) in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }

}

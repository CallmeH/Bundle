//
//  HomeViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //add gesture swipe here
    
    @IBAction func unwindFromInput(_ segue: UIStoryboardSegue) {
        print("unwind from input")
        inputViewController?.dismissKeyboard()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {fatalError("Cannot initialize storyboard")}
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func unwindFromCheckin(_ segue: UIStoryboardSegue) {
        print("unwind from checkin")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {fatalError("Cannot initialize storyboard")}
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    //additional features:
    //review completed bundles
    
    
    //see all future todos
    

}


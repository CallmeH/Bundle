//
//  InputTodoViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class InputTodoViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var inputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.inputTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inputTextView.returnKeyType = .done
        self.inputTextView.text = ""
        self.inputTextView.textColor = UIColor(red: 238, green: 238, blue: 238, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.inputTextView.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        self.inputTextView.resignFirstResponder()
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

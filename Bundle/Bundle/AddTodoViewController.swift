//
//  AddTodoViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/8/2.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class AddTodoViewController: UIViewController, UITextViewDelegate {
    
    var existingLabel: String?
    
    @IBOutlet weak var entireView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var inputTextViewLowerConstraints: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.center = entireView.center
        inputTextView.delegate = self
        inputTextView.text = existingLabel ?? ""
        inputTextView.returnKeyType = .done
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
//            inputTextViewLowerConstraints.secondItem = keyboardRect.height + 30
            print(inputTextViewLowerConstraints)
            popupView.frame.origin.y =  entireView.frame.height - (keyboardRect.height) - popupView.frame.height - 30
//            print("\(entireView.frame.height),, \(keyboardRect.height),, \(popupView.frame.height)")
//            placeholderView.frame.size.height = keyboardRect.height
        } else {
            popupView.center = entireView.center
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        inputTextView.becomeFirstResponder()
//        guard let keyboardRect = (UIKeyboardFrameEndUserInfoKey as? NSValue)?.cgRectValue else {return}
//        popupView.frame.origin.y =  entireView.frame.height - (keyboardRect.height) - popupView.frame.height
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            guard inputTextView.text != "" else { return true }
            performSegue(withIdentifier: "TodoAdded", sender: Any?.self)
        }
        return true
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

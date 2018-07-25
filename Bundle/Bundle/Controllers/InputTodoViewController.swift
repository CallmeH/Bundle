//
//  InputTodoViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class InputTodoViewController: UIViewController, UITextViewDelegate {
    
    var todoAtInput: Todo?
    //√ cancel button--unwind set in Home
    @IBOutlet weak var inputTextView: UITextView!
    //complete icon for dragging
    //now I need 3 buttons for before/after?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.inputTextView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // call keyboard automatically
    override func viewWillAppear(_ animated: Bool) {
        inputTextView.returnKeyType = .done
        self.inputTextView.text = ""
        self.inputTextView.textColor = UIColor(red: 238, green: 238, blue: 238, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.inputTextView.becomeFirstResponder()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.inputTextView.resignFirstResponder()
    }
    
    //toggle resuable
    @IBAction func reusableToggled(_ sender: UISwitch) {
//        sender.isOn ? todoAtInput.isRecycled = true : todoAtInput.isRecycled = false
        if sender.isOn {
            todoAtInput?.isRecycled = true
            print("recycle!")
        } else {
            todoAtInput?.isRecycled = false
            print("non-recycle!")
        }
    }
    
    
    //passing preposition to AssignToEvent
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        func inputToAssign(preposition: String) {
            print("\(preposition) tapped")
            let destination = segue.destination as! AssignToEventViewController
            destination.prepositionStatus = preposition.capitalized
            destination.todoAtAssign = todoAtInput
        }
        switch identifier {
        case "beforeAssign":
            inputToAssign(preposition: "before")
        case "afterAssign":
            inputToAssign(preposition: "after")
        case "whenAssign":
            inputToAssign(preposition: "when")
        default:
            inputToAssign(preposition: "Swipe to choose when")
        }
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

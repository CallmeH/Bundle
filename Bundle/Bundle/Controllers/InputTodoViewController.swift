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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    //√toggle resuable
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
    
    //before/when/after
    @IBOutlet weak var prepositionChoice: UISegmentedControl!
    var prepositionStatus = prepType.before
    @IBAction func prepositionTapped(_ sender: UISegmentedControl) {
        switch prepositionChoice.selectedSegmentIndex {
        case 0:
            prepositionStatus = .before
        case 1:
            prepositionStatus = .when
        case 2:
            prepositionStatus = .after
        default:
            prepositionStatus = .before
        }
        performSegue(withIdentifier: "toAssign", sender: Any?.self)
    }
    
    
    
    //√ passing preposition to AssignToEvent
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.inputTextView.resignFirstResponder()
        guard segue.identifier != nil else {return}
        let destination = segue.destination as! AssignToEventViewController
        destination.prepositionStatus = prepositionStatus
//        func inputToAssign(preposition: prepType) {
//            print("\(preposition) tapped")
//            let destination = segue.destination as! AssignToEventViewController
//            destination.prepositionStatus = preposition.displayName
//            destination.todoAtAssign = todoAtInput
//        }
//        switch identifier {
//        case "beforeAssign":
//            inputToAssign(preposition: .before)
//        case "afterAssign":
//            inputToAssign(preposition: .after)
//        case "whenAssign":
//            inputToAssign(preposition: .when)
//        default:
//            inputToAssign(preposition: .when)
//        }
    }
    
    // unwind from Assign
    @IBAction func unwindFromAssigntoInput(_ segue: UIStoryboardSegue) {
        print("unwind from assign")
    }
    
}

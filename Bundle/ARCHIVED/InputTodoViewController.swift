//
//  InputTodoViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class InputTodoViewController: UIViewController, UITextViewDelegate {
    
    var selectedState: Bool = false
    @IBOutlet weak var inputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputTextView.delegate = self
        self.inputTextView.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // call keyboard automatically
    override func viewWillAppear(_ animated: Bool) {
        inputTextView.returnKeyType = .done
        self.inputTextView.textColor = UIColor(red: 238, green: 238, blue: 238, alpha: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.inputTextView.becomeFirstResponder()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            guard inputTextView.text != "" else { return true }
            performSegue(withIdentifier: "toAssign", sender: Any?.self)
        }
        return true
    }
    
    
    //√toggle repeating
    @IBAction func reusableToggled(_ sender: UISwitch) {
//        sender.isOn ? todoAtInput.isRecycled = true : todoAtInput.isRecycled = false
        if sender.isOn {
            selectedState = true
            print("recycle!")
        } else {
            selectedState = false
            print("non-recycle!")
        }
    }
    
    //before/when/after
//    @IBOutlet weak var prepositionChoice: MySelectableSegmentedControl!
//    var prepositionStatus = prepType.before
//    @IBAction func prepositionTapped(_ sender: MySelectableSegmentedControl) {
//        switch prepositionChoice.selectedSegmentIndex {
//        case 0:
//            prepositionStatus = .before
//        case 1:
//            prepositionStatus = .when
//        case 2:
//            prepositionStatus = .after
//        default:
//            prepositionStatus = .before
//        }
//        performSegue(withIdentifier: "toAssign", sender: Any?.self)
//    }
    
    
    
    //√ passing preposition to AssignToEvent
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.inputTextView.resignFirstResponder()
        
        let initialTodo = CoreDataHelper.newTodo()
        initialTodo.title = inputTextView.text
        initialTodo.isRepeated = selectedState
        initialTodo.isCompleted = false
        initialTodo.isSelected = false
//        CoreDataHelper.save()
        

        guard segue.identifier != nil else {return}
        let destination = segue.destination as! AssignToEventViewController
        destination.todoAtAssign = initialTodo
        
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

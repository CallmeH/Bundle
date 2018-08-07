//
//  AddFirstScreenViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/31.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class AddFirstScreenViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var repeatButtonDisplay: UIButton!
    @IBOutlet weak var todoButtonDisplay: UIButton!
    @IBOutlet weak var inputTodoTextView: UITextView!
    @IBOutlet weak var entireView: UIView!
    @IBOutlet weak var defaultTagButtonDisplay: UIButton!
    @IBOutlet weak var eventButtonDisplay: UIButton!
    // timeTag = defaultTag (before/after/when), additional tags are named customTag
    
    var prep: Int = Constant.prepositionPlaceholder.before
    var selectedEvent: [Event]?
    var repeatChoice: Bool = false
    var todoLabel: String?
    
//    var todoBoxOriginalFrameHeight: CGFloat?
    var todoWasSetBefore = false
    var eventWasSetBefore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTodoTextView.delegate = self
        repeatButtonDisplay.setTitle("Just once,", for: .normal)
        defaultTagButtonDisplay.setTitle("before", for: .normal)
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
//        todoBoxOriginalFrameHeight = inputTodoTextView.frame.origin.y
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//    }
    
//    @objc func keyboardWillChange(notification: Notification) {
//        guard let keyboardRect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
//        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame {
//            //            inputTextViewLowerConstraints.secondItem = keyboardRect.height + 30
////            print(inputTextViewLowerConstraints)
//            inputTodoTextView.frame.origin.y =  entireView.frame.height - (keyboardRect.height) - inputTodoTextView.frame.height - 30
//            //            print("\(entireView.frame.height),, \(keyboardRect.height),, \(popupView.frame.height)")
//            //            placeholderView.frame.size.height = keyboardRect.height
//        } else {
//            guard let todoBox = todoBoxOriginalFrameHeight else {return}
//            inputTodoTextView.frame.origin.y = todoBox
//        }
//    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
//            guard inputTodoTextView.text != "" else { return true }
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if todoWasSetBefore {
            return
        } else {
            inputTodoTextView.text = ""
            todoWasSetBefore = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        todoButtonDisplay.titleLabel?.text =
        super.viewWillAppear(true)
        if eventWasSetBefore {
            var arrayEventTitles = [String]()
            for i in selectedEvent! {
                arrayEventTitles.append(i.name!)
            }
            eventButtonDisplay.setTitle(arrayEventTitles.joined(separator: ", "), for: .normal)
        } else {
            eventButtonDisplay.setTitle("e.g. I send out the draft", for: .normal)
        }
    }
    
    @IBAction func repeatTagEditTapped(_ sender: UIButton) {
        if repeatChoice == true {
            repeatChoice = false
            sender.setTitle("Just once,", for: .normal)
//            reloadInputViews()
//            return repeatChoice
        } else {
            repeatChoice = true
            sender.setTitle("Always", for: .normal)
//            reloadInputViews()
//            return repeatChoice
        }
    }
    
    @IBAction func timeTagEditTapped(_ sender: UIButton) {
        if prep == Constant.prepositionPlaceholder.before {
            prep = Constant.prepositionPlaceholder.when
            sender.setTitle("when", for: .normal)
//            defaultTagButtonDisplay.titleLabel?.text = "after"
//            reloadInputViews()
        } else if prep == Constant.prepositionPlaceholder.when {
            prep = Constant.prepositionPlaceholder.after
            sender.setTitle("after", for: .normal)
//            defaultTagButtonDisplay.titleLabel?.text = "when"
//            reloadInputViews()
        } else {
            prep = Constant.prepositionPlaceholder.before
            sender.setTitle("before", for: .normal)
//            defaultTagButtonDisplay.titleLabel?.text = "before"
//            reloadInputViews()
        }
    }
    
//    textviewd
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "AddTodoText":
            let destination = segue.destination as! AddTodoViewController
            destination.existingLabel = todoLabel
//            if todoLabel == nil {
//                destination.inputTextView.text = ""
//            } else {
//                destination.inputTextView.text = todoLabel
//            }
//            if (todoButtonDisplay.titleLabel?.text)! == nil {
//                destination.inputTextView.text = ""
//            } else {
//                destination.inputTextView.text = todoButtonDisplay.titleLabel?.text
//            }
//            destination.inputTextView.text = todoButtonDisplay.titleLabel?.text ?? ""
        case "AddEvent":
//            let destination = segue.destination as! AddEventViewController
//            destination.allEvents
            print("choose new event")
        case "saveNewTodoWithEventTapped":
            print("successfully saved")
        default:
            print("unable to add todo or event")
        }
    }
    
    @IBAction func saveNewTodoWithEventTapped(_ sender: UIButton) {
//        guard todoButtonDisplay.titleLabel?.text != nil else { return }
//        guard todoButtonDisplay.titleLabel?.text != "" else { return }
//        guard inputTodoTextView.text != nil else {return}
//        guard inputTodoTextView.text != "" else {return}
//        guard selectedEvent != nil else { return }
        guard todoWasSetBefore else {return}
        guard eventWasSetBefore else {return}
        for i in selectedEvent! {
            let newTodo = CoreDataHelper.newTodo()
    //        newTodo.title = todoButtonDisplay.titleLabel?.text
            newTodo.title = inputTodoTextView.text
            newTodo.isRepeated = repeatChoice
            newTodo.hasTimeTag = CoreDataHelper.retrieveAllDefaultTags().sorted {$0.preposition < $1.preposition}[prep]
            newTodo.isCompleted = false
            newTodo.isSelected = false
            newTodo.belongToEvent = i
            CoreDataHelper.save()
        }
        performSegue(withIdentifier: "saveNewTodoWithEventTapped", sender: Any?.self)
    }
    
    
    @IBAction func unwindFromTodoToAddFirst(_ sender: UIStoryboardSegue) {
        let sourceViewController = sender.source as! AddTodoViewController
        todoLabel = sourceViewController.inputTextView.text
        todoButtonDisplay.setTitle(todoLabel, for: .normal)
    }
    
    @IBAction func unwindFromEventToAddFirst(_ sender: UIStoryboardSegue) {
//        let sourceViewController = sender.source as! AddEventViewController
//        guard let indexPaths = sourceViewController.addToEventsCollectionView.indexPathsForSelectedItems else { return }
        
    }
}

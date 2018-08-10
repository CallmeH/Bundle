//
//  AddFirstScreenViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/31.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit
import Crashlytics

class AddFirstScreenViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var repeatButtonDisplay: UIButton!
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
        setUpView()
        inputTodoTextView.delegate = self
        inputTodoTextView.text = "\ne.g.Email Daniel"
        repeatButtonDisplay.setTitle("Just once,", for: .normal)
        defaultTagButtonDisplay.setTitle("before", for: .normal)
        inputTodoTextView.returnKeyType = .done
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
//        Answers.logCustomEvent(withName: "land on add", customAttributes: ["Funnel":"fresh add", "Flow": "Add", "Controller":"AddFirst"])
    }
    
    //FIXME: view move with keyboard? listen to events (refer to see deleted lines)
    
    @IBOutlet weak var instructionsCard: UIView!
    @IBOutlet weak var repeatChoiceCard: UIView!
    @IBOutlet weak var reminderCard: UIView!
    @IBOutlet weak var timeTagCard: UIView!
    @IBOutlet weak var eventCard: UIView!
    func setUpView() {
        instructionsCard.layer.shadowOffset = CGSize(width: 0, height: 1)
        instructionsCard.layer.shadowOpacity = 1
        instructionsCard.layer.shadowColor = UIColor.AlmostWhite.cgColor
        instructionsCard.layer.shadowRadius = 35
        func boarderBlueGrey(arrayOfCards: [UIView]) {
            for i in arrayOfCards {
                i.layer.borderWidth = 1
                i.layer.borderColor = UIColor.BlueGrey.cgColor
            }
        }
        boarderBlueGrey(arrayOfCards: [repeatChoiceCard,reminderCard,timeTagCard,eventCard])
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
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
        super.viewWillAppear(true)
        if eventWasSetBefore {
            var arrayEventTitles = [String]()
            for i in selectedEvent! {
                arrayEventTitles.append(i.name!)
            }
            let chosenEvents = arrayEventTitles.joined(separator: "; ")
            var truncated = ""
            if chosenEvents.count > 100 {
                var lengthCounter = 0
                var showNumber = 0
                for i in arrayEventTitles {
                    if lengthCounter + i.count <= 100 {
                        lengthCounter += i.count
                        truncated = truncated + i + "; "
                        showNumber += 1
                    }
                }
                if showNumber + 1 == arrayEventTitles.count {
                    truncated += "\nand 1 more event"
                } else {
                    truncated += "\nand \(arrayEventTitles.count - showNumber) more events"
                }
            } else {
                truncated = arrayEventTitles.joined(separator: ";  ")
            }
            eventButtonDisplay.setTitle(truncated, for: .normal)
        } else {
            eventButtonDisplay.setTitle("e.g. sending out the draft", for: .normal)
        }
    }
    
    @IBAction func repeatTagEditTapped(_ sender: UIButton) {
        if repeatChoice == true {
            repeatChoice = false
            sender.setTitle("Just once,", for: .normal)
        } else {
            repeatChoice = true
            sender.setTitle("Always", for: .normal)
        }
    }
    
    @IBAction func eventChoiceButtonTapped(_ sender: UIButton) {
        let popOver = UIStoryboard(name: "Add", bundle: nil).instantiateViewController(withIdentifier: "SetYourEvents") as! AddEventViewController
        self.addChildViewController(popOver)
        popOver.view.frame = self.view.frame
        self.view.addSubview(popOver.view)
        popOver.didMove(toParentViewController: self)
    }
    
    //FIXME: works now, but how to customize tags?
    @IBAction func timeTagEditTapped(_ sender: UIButton) {
        if prep == Constant.prepositionPlaceholder.before {
            prep = Constant.prepositionPlaceholder.when
            sender.setTitle("when", for: .normal)
        } else if prep == Constant.prepositionPlaceholder.when {
            prep = Constant.prepositionPlaceholder.after
            sender.setTitle("after", for: .normal)
        } else {
            prep = Constant.prepositionPlaceholder.before
            sender.setTitle("before", for: .normal)
        }
    }
    
//    textviewd
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "AddEvent":
            let destination = segue.destination as! AddEventViewController
            destination.previouslySelectedEvents = selectedEvent ?? []
            print("choose new event")
        case "saveNewTodoWithEventTapped":
            print("successfully saved")
        default:
            print("unable to add todo or event")
        }
    }
    
    @IBAction func saveNewTodoWithEventTapped(_ sender: UIButton) {
        guard todoWasSetBefore else {return}
        guard eventWasSetBefore else {return}
        for i in selectedEvent! {
    //        newTodo.title = todoButtonDisplay.titleLabel?.text
            let allTodos = inputTodoTextView.text
            let array = allTodos?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).components(separatedBy: ";").filter{!($0.isEmpty)}
            for k in array ?? [""] {
                guard k != "" else {return}
                let newTodo = CoreDataHelper.newTodo()
                newTodo.title = k
                newTodo.isRepeated = repeatChoice
                newTodo.hasTimeTag = CoreDataHelper.retrieveAllDefaultTags().sorted {$0.preposition < $1.preposition}[prep]
                newTodo.isCompleted = false
                newTodo.isSelected = false
                newTodo.belongToEvent = i
                CoreDataHelper.save()
            }
        }
//        Answers.logCustomEvent(withName: "Add flow completed", customAttributes: ["Category":"Core flow add", "Flow": "Add", "Controller":"AddFirst"])
        performSegue(withIdentifier: "saveNewTodoWithEventTapped", sender: Any?.self)
    }
    
    @IBAction func unwindFromEventToAddFirst(_ sender: UIStoryboardSegue) {
    }
}


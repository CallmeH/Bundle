//
//  AddFirstScreenViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/31.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class AddFirstScreenViewController: UIViewController {

    @IBOutlet weak var repeatButtonDisplay: UIButton!
    @IBOutlet weak var todoButtonDisplay: UIButton!
    @IBOutlet weak var defaultTagButtonDisplay: UIButton!
    @IBOutlet weak var eventButtonDisplay: UIButton!
    // timeTag = defaultTag (before/after/when), additional tags are named customTag
    
    var prep: Int = Constant.prepositionPlaceholder.before
    var selectedEvent: Event?
    var repeatChoice: Bool = false
    var todoLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repeatButtonDisplay.setTitle("Just once,", for: .normal)
        defaultTagButtonDisplay.setTitle("before", for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        todoButtonDisplay.titleLabel?.text =
        eventButtonDisplay.setTitle(selectedEvent?.name, for: .normal)
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
            prep = Constant.prepositionPlaceholder.after
            sender.setTitle("after", for: .normal)
//            defaultTagButtonDisplay.titleLabel?.text = "after"
//            reloadInputViews()
        } else if prep == Constant.prepositionPlaceholder.after {
            prep = Constant.prepositionPlaceholder.when
            sender.setTitle("when", for: .normal)
//            defaultTagButtonDisplay.titleLabel?.text = "when"
//            reloadInputViews()
        } else {
            prep = Constant.prepositionPlaceholder.before
            sender.setTitle("before", for: .normal)
//            defaultTagButtonDisplay.titleLabel?.text = "before"
//            reloadInputViews()
        }
    }
    
    
    
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
        guard todoButtonDisplay.titleLabel?.text != nil else { return }
        guard todoButtonDisplay.titleLabel?.text != "" else { return }
        guard selectedEvent != nil else { return }
        let newTodo = CoreDataHelper.newTodo()
        newTodo.title = todoButtonDisplay.titleLabel?.text
        newTodo.isRepeated = repeatChoice
        newTodo.hasTimeTag = CoreDataHelper.retrieveAllDefaultTags().sorted {$0.preposition < $1.preposition}[prep]
        newTodo.isCompleted = false
        newTodo.isSelected = false
        newTodo.belongToEvent = selectedEvent
        CoreDataHelper.save()
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

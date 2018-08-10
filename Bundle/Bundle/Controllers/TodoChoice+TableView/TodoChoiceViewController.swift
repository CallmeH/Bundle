//
//  TodoChoiceViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit
import Crashlytics

class TodoChoiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var currentEvent: Event?
    var accessTodo: [Todo]? = nil {
        didSet {
            choiceTableView.reloadData()
        }
    }
    var selectionCounter: Int = 0
    var totalTodoCounter: Int = 0
    
    @IBOutlet weak var choiceTableView: UITableView!
    @IBOutlet weak var eventNameDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choiceTableView.allowsMultipleSelection = true
        choiceTableView.delegate = self
        choiceTableView.dataSource = self
        let allTodo = currentEvent?.todoArray?.allObjects as? [Todo]
        accessTodo = allTodo?.filter{$0.isCompleted == false}
        for i in accessTodo! {
            i.isSelected = false
        }
        if (currentEvent?.name?.count)! > 80 {
            eventNameDisplay.text = String((currentEvent?.name?.prefix(77))!) + "..."
        } else {
            eventNameDisplay.text = currentEvent?.name
        }
        totalTodoCounter = accessTodo?.count ?? 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        choiceTableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToTodoChoice(_ segue: UIStoryboardSegue) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Single use"
        } else {
            return "Repeated reminders"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard accessTodo != nil else { return 0 }
        if section == 0 {
            return accessTodo?.filter {$0.isRepeated == false}.count ?? 0
        } else {
            return accessTodo?.filter {$0.isRepeated == true}.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTodosTableViewCell", for: indexPath) as! TodoChoiceTableViewCell
        
        var nonrepeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == false} ?? []
        var repeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == true} ?? []
        var todoPlaceholder: Todo
        cell.todoTagDisplay.layer.cornerRadius = 3
        cell.todoTagDisplay.layer.masksToBounds = true
        cell.todoTagDisplay.backgroundColor = UIColor.BlueGrey
        cell.todoTagDisplay.textColor = UIColor.LightGrey
        if indexPath.section == 0 {
            todoPlaceholder = nonrepeatingCopy[indexPath.row]
            cell.todoTagDisplay.text = tagToString(todoPlaceholder.hasTimeTag!)
            cell.todoForEvent.text = todoPlaceholder.title
            cell.repeatDisplay.isSelected = true
            if nonrepeatingCopy[indexPath.row].isSelected {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else {
            todoPlaceholder = repeatingCopy[indexPath.row]
            cell.todoTagDisplay.text = tagToString(todoPlaceholder.hasTimeTag!)
            cell.todoForEvent.text = todoPlaceholder.title
            cell.repeatDisplay.isSelected = false
            if repeatingCopy[indexPath.row].isSelected {
                cell.accessoryType = .checkmark
                cell.reloadInputViews()
            } else {
                cell.accessoryType = .none
                cell.reloadInputViews()
            }
        }
        cell.repeatButtonTouched = { (cellin) in
            guard let indexPath = tableView.indexPath(for: cellin) else { return }
            if todoPlaceholder.isRepeated {
                todoPlaceholder.isRepeated = false
                CoreDataHelper.save()
                cell.repeatDisplay.isSelected = false
                print("change to single-use")
                let allTodo = self.currentEvent?.todoArray?.allObjects as? [Todo]
                self.accessTodo = allTodo?.filter{$0.isCompleted == false}
                nonrepeatingCopy = self.accessTodo?.filter {$0.isRepeated == false} ?? []
                repeatingCopy = self.accessTodo?.filter {$0.isRepeated == true} ?? []
                self.choiceTableView.reloadData()
            } else {
                todoPlaceholder.isRepeated = true
                CoreDataHelper.save()
                cell.repeatDisplay.isSelected = true
                print("change to repeating")
                nonrepeatingCopy = self.accessTodo?.filter {$0.isRepeated == false} ?? []
                repeatingCopy = self.accessTodo?.filter {$0.isRepeated == true} ?? []
                self.choiceTableView.reloadData()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nonrepeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == false} ?? []
        let repeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == true} ?? []
        func callCheckmark(_ repeatOrNot: [Todo]) {
            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
                if repeatOrNot[indexPath.row].isSelected {
                    cell.accessoryType = .none
                    repeatOrNot[indexPath.row].isSelected = false
                    print(repeatOrNot[indexPath.row].isSelected)
                    choiceTableView.reloadData()
                    print("set to not selected")
                    selectionCounter -= 1
                } else {
                    cell.accessoryType = .checkmark
                    repeatOrNot[indexPath.row].isSelected = true
                    print(repeatOrNot[indexPath.row].isSelected)
                    print("set to selected")
                    choiceTableView.reloadData()
                    selectionCounter += 1
                }
            }
        }
        if indexPath.section == 0 {
            callCheckmark(nonrepeatingCopy)
        } else {
            callCheckmark(repeatingCopy)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let nonrepeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == false} ?? []
        let repeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == true} ?? []
        if editingStyle == .delete {
            if indexPath.section == 0{
                let todoToDelete = nonrepeatingCopy[indexPath.row]
                CoreDataHelper.deleteTodo(todo: todoToDelete)
                let allTodo = currentEvent?.todoArray?.allObjects as? [Todo]
                accessTodo = allTodo?.filter{$0.isCompleted == false}
                totalTodoCounter = accessTodo?.count ?? 0
            } else {
                let todoToDelete = repeatingCopy[indexPath.row]
                CoreDataHelper.deleteTodo(todo: todoToDelete)
                let allTodo = currentEvent?.todoArray?.allObjects as? [Todo]
                accessTodo = allTodo?.filter{$0.isCompleted == false}
                totalTodoCounter = accessTodo?.count ?? 0
            }
        }
    }
    
    
    @IBAction func afterSelectionButton(_ sender: UIButton) {
        if selectionCounter == 0 {
            Answers.logCustomEvent(withName: "no todos selected", customAttributes: ["Tag":"Work-around", "Flow": "Checkin", "Controller":"TodoChoice"])
            let popOver = UIStoryboard(name: "Checkin", bundle: nil).instantiateViewController(withIdentifier: "ChooseYourTodos") as! BundleNamingPromtViewController
            self.addChildViewController(popOver)
            popOver.view.frame = self.view.frame
            self.view.addSubview(popOver.view)
            popOver.didMove(toParentViewController: self)
        } else {
            Answers.logCustomEvent(withName: "todos selected", customAttributes: ["Tag":"Expected", "Flow": "Checkin", "Controller":"TodoChoice"])
            performSegue(withIdentifier: "toBundle", sender: Any?.self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "toBundle":
            CoreDataHelper.save()
            Answers.logCustomEvent(withName: "chosen todos", customAttributes: ["Funnel":"todochoice->bundle", "Flow": "Checkin", "Controller":"TodoChoice"])
            let destination = segue.destination as! BundleViewController
            destination.currentEvent = currentEvent
        case "abandonTodoChoice":
            Answers.logCustomEvent(withName: "quit choosing todos", customAttributes: ["Funnel":"Cancel", "Flow": "Checkin", "Controller":"TodoChoice"])
            if totalTodoCounter == 0 {
                let destination = segue.destination as! CheckinViewController
                destination.CheckinCollectionView.reloadData()
            }
        default:
            print ("failed to pass data from todochoice to bundle")
        }
    }
    
}

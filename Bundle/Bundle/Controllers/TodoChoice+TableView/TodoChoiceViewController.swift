//
//  TodoChoiceViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit
class TodoChoiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var currentEvent: Event?
    var accessTodo: [Todo]? = nil {
        didSet {
            choiceTableView.reloadData()
        }
    }
//    var repeatingCopy: [Todo]? = nil {
//        didSet {
//            choiceTableView.reloadData()
//        }
//    }
//    var nonrepeatingCopy: [Todo]? = nil {
//        didSet {
//            choiceTableView.reloadData()
//        }
//    }
    var selectionCounter: Int = 0
//    var bundleToPass: [Todo]?
    
    @IBOutlet weak var choiceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        accessTodo = CoreDataHelper.retrieveAllTodo().filter(<#T##isIncluded: (Todo) throws -> Bool##(Todo) throws -> Bool#>)
        choiceTableView.allowsMultipleSelection = true
//        self.choiceTableView.isEditing = true
        choiceTableView.delegate = self
        choiceTableView.dataSource = self
        let allTodo = currentEvent?.todoArray?.allObjects as? [Todo]
        accessTodo = allTodo?.filter{$0.isCompleted == false}
        for i in accessTodo! {
            i.isSelected = false
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        accessTodo = currentEvent?.todoArray?.allObjects as? [Todo]
//        for i in accessTodo! {
//            i.isSelected = false
//        }
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
//        let allTodos = CoreDataHelper.retrieveAllTodo()
//        let specificTodo = allTodos.filter {$0.belongToEvent == currentEvent}
//        cell.todoForEvent.text = specificTodo[indexPath.row].title
//        print(currentEvent?.todoArray!)
        
//        print(accessTodo)
//        print(accessTodo?.allObjects)
        
        
        
        var nonrepeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == false} ?? []
        var repeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == true} ?? []
        var todoPlaceholder: Todo
        if indexPath.section == 0 {
            todoPlaceholder = nonrepeatingCopy[indexPath.row]
            cell.todoForEvent.text = todoPlaceholder.title
            cell.repeatDisplay.isSelected = true
            if nonrepeatingCopy[indexPath.row].isSelected {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else {
            todoPlaceholder = repeatingCopy[indexPath.row]
            cell.todoForEvent.text = todoPlaceholder.title
            cell.repeatDisplay.isSelected = false
            if repeatingCopy[indexPath.row].isSelected {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        cell.repeatButtonTouched = { (cellin) in
            guard let indexPath = tableView.indexPath(for: cellin) else { return }
            if todoPlaceholder.isRepeated {
                todoPlaceholder.isRepeated = false
                cell.repeatDisplay.isSelected = false
                print("change to single-use")
                let allTodo = self.currentEvent?.todoArray?.allObjects as? [Todo]
                self.accessTodo = allTodo?.filter{$0.isCompleted == false}
                nonrepeatingCopy = self.accessTodo?.filter {$0.isRepeated == false} ?? []
                repeatingCopy = self.accessTodo?.filter {$0.isRepeated == true} ?? []
                self.choiceTableView.reloadData()
            } else {
                todoPlaceholder.isRepeated = true
                cell.repeatDisplay.isSelected = true
                print("change to repeating")
                nonrepeatingCopy = self.accessTodo?.filter {$0.isRepeated == false} ?? []
                repeatingCopy = self.accessTodo?.filter {$0.isRepeated == true} ?? []
                self.choiceTableView.reloadData()
            }
        }
//        cell.showsReorderControl = true
            //String(indexPath.count)//accessTodo![indexPath.row].title

        return cell
    }
    
    // drag and change order
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        accessTodo = self.currentEvent?.todoArray?.allObjects as? [Todo]
//        let movedObject = accessTodo![sourceIndexPath.row]
//        accessTodo!.remove(at: sourceIndexPath.row)
//        accessTodo!.insert(movedObject, at: destinationIndexPath.row)
//    }

    
    
//
//    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nonrepeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == false} ?? []
        let repeatingCopy: [Todo] = accessTodo?.filter {$0.isRepeated == true} ?? []
        func callCheckmark(_ repeatOrNot: [Todo]) {
            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//                if repeatOrNot[indexPath.row].isSelected == false {
//                    repeatOrNot[indexPath.row].isSelected = true
//                    print("set to not selected")
//                } else {
//                    repeatOrNot[indexPath.row].isSelected = false
//                    print("set to selected")
//                }
                if repeatOrNot[indexPath.row].isSelected {
                    cell.accessoryType = .none
                    repeatOrNot[indexPath.row].isSelected = false
                    print(repeatOrNot[indexPath.row].isSelected)
                    print("set to not selected")
                    selectionCounter -= 1
                } else {
                    cell.accessoryType = .checkmark
                    repeatOrNot[indexPath.row].isSelected = true
                    print(repeatOrNot[indexPath.row].isSelected)
                    print("set to selected")
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
        // FIXME: Uncomment this line if this doesn't fix
//        accessTodo = self.currentEvent?.todoArray?.allObjects as? [Todo]
        if editingStyle == .delete {
            let todoToDelete = accessTodo![indexPath.row]
            CoreDataHelper.deleteTodo(todo: todoToDelete)
            let allTodo = currentEvent?.todoArray?.allObjects as? [Todo]
            accessTodo = allTodo?.filter{$0.isCompleted == false}
//            accessTodo = CoreDataHelper.retrieveAllTodo()
            tableView.reloadData()
        }
    }
    
    
    @IBAction func afterSelectionButton(_ sender: UIButton) {
//        guard choiceTableView.indexPathsForSelectedRows != [] else {return}
//        guard choiceTableView.indexPathsForSelectedRows != nil else { return }
        guard selectionCounter > 0 else {return}
        performSegue(withIdentifier: "toBundle", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "toBundle":
            CoreDataHelper.save()
            let destination = segue.destination as! BundleViewController
            destination.currentEvent = currentEvent
//            destination.bundleCopy = accessTodo!.filter { $0.isCompleted == true } as! BundledTodo
        default:
            print ("failed to pass data from todochoice to bundle")
        }
    }
    
}

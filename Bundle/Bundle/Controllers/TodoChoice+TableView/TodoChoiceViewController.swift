//
//  TodoChoiceViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit
class TodoChoiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var currentEvent: Event?
    var accessTodo: [Todo]? = nil {
        didSet {
            choiceTableView.reloadData()
        }
    }
//    var bundleToPass: [Todo]?
    
    @IBOutlet weak var choiceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        accessTodo = CoreDataHelper.retrieveAllTodo().filter(<#T##isIncluded: (Todo) throws -> Bool##(Todo) throws -> Bool#>)
        choiceTableView.allowsMultipleSelection = true
//        self.choiceTableView.isEditing = true
        choiceTableView.delegate = self
        choiceTableView.dataSource = self
        accessTodo = currentEvent?.todoArray?.allObjects as? [Todo]
        for i in accessTodo! {
            i.isSelected = false
        }
        // Do any additional setup after loading the view.
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentEvent?.todoArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTodosTableViewCell", for: indexPath) as! TodoChoiceTableViewCell
//        let allTodos = CoreDataHelper.retrieveAllTodo()
//        let specificTodo = allTodos.filter {$0.belongToEvent == currentEvent}
//        cell.todoForEvent.text = specificTodo[indexPath.row].title
//        print(currentEvent?.todoArray!)
        
//        print(accessTodo)
//        print(accessTodo?.allObjects)
        cell.todoForEvent.text = accessTodo![indexPath.row].title
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
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                accessTodo![indexPath.row].isSelected = false
                print(cell.isSelected)
            }
            else{
                cell.accessoryType = .checkmark
                accessTodo![indexPath.row].isSelected = true
                print(cell.isSelected)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        accessTodo = self.currentEvent?.todoArray?.allObjects as? [Todo]
        if editingStyle == .delete {
            let todoToDelete = accessTodo![indexPath.row]
            CoreDataHelper.deleteTodo(todo: todoToDelete)
            
//            accessTodo = CoreDataHelper.retrieveAllTodo()
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "toBundle":
            let destination = segue.destination as! BundleViewController
            destination.currentEvent = currentEvent
//            destination.bundleCopy = accessTodo!.filter { $0.isCompleted == true } as! BundledTodo
        default:
            print ("failed to pass data from todochoice to bundle")
        }
    }
    
}

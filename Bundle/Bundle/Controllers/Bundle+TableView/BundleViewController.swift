//
//  BundleViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

class BundleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var bundleCopy: [Todo]? = nil {
        didSet {
            bundleTableView.reloadData()
        }
    }
    var currentEvent: Event?
    var completedCounter: Int = 0
    @IBOutlet weak var bundleNameTextField: UITextField!
    
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
        guard bundleCopy != nil else { return 0 }
        if section == 0 {
            return bundleCopy?.filter {$0.isRepeated == false}.count ?? 0
        } else {
            return bundleCopy?.filter {$0.isRepeated == true}.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chosenTodosTableViewCell", for: indexPath) as! BundleTableViewCell
//        cell.showsReorderControl = true
        let nonrepeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == false} ?? []
        let repeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == true} ?? []
        var todoPlaceholder: Todo
        if indexPath.section == 0 {
//            guard nonrepeatingCopy != nil else {return}
            todoPlaceholder = nonrepeatingCopy[indexPath.row]
            cell.todoForBundle.text = todoPlaceholder.title
            cell.onButtonTouched = { (cell) in
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                print ("button tapped at\(indexPath.row)")
                if todoPlaceholder.isCompleted == false {
                    todoPlaceholder.isCompleted = true
                    self.completedCounter += 1
                } else {
                    todoPlaceholder.isCompleted = false
                    self.completedCounter -= 1
                }
            }
        } else {
//            guard repeatingCopy != nil else {return}
            todoPlaceholder = repeatingCopy[indexPath.row]
            cell.todoForBundle.text = todoPlaceholder.title
            cell.onButtonTouched = { (cell) in
                guard let indexPath = tableView.indexPath(for: cell) else { return }
                print ("button tapped at\(indexPath.row)")
                if todoPlaceholder.isCompleted == false {
                    todoPlaceholder.isCompleted = true
                    self.completedCounter += 1
                } else {
                    todoPlaceholder.isCompleted = false
                    self.completedCounter -= 1
                }
            }
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//    }

    @IBOutlet weak var bundleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bundleTableView.delegate = self
        bundleTableView.dataSource = self
        bundleTableView.allowsMultipleSelection = true
        
        let bundleAll = currentEvent?.todoArray?.allObjects as? [Todo]
        bundleCopy = bundleAll?.filter { $0.isSelected == true}
//        NSPredicate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        return UITableViewCellEditingStyle.init(rawValue: 3)!
//    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "bundleCompleted":
            guard completedCounter == bundleCopy?.count else {return}
            let bundle = CoreDataHelper.newBundle()
            bundle.name = bundleNameTextField.text
            bundle.dateCompleted = Date()
            let nonrepeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == false} ?? []
            let repeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == true} ?? []
            for i in nonrepeatingCopy {
                bundle.addToContainsTodos(i)
            }
            for i in repeatingCopy {
                let duplicate = i
                duplicate.isRepeated = false
                bundle.addToContainsTodos(duplicate)
                i.isSelected = false
                i.isCompleted = false
            }
            CoreDataHelper.save()
//            destination.currentEvent = currentEvent
        //            destination.bundleCopy = accessTodo!.filter { $0.isCompleted == true } as! BundledTodo
        default:
            print ("failed to pass data")
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

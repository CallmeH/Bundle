//
//  BundleViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit

class BundleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var bundleCopy: [Todo]? = nil {
        didSet {
            bundleTableView.reloadData()
        }
    }
    var currentEvent: Event?
    var completedCounter: Int = 0
    var somethingWasPutBack = 0
    @IBOutlet weak var bundleNameTextField: UITextField!

    @IBOutlet weak var bundleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bundleTableView.delegate = self
        bundleTableView.dataSource = self
        bundleTableView.allowsMultipleSelection = true
        bundleTableView.isEditing = true
        
//        let bundleAll = currentEvent?.todoArray?.allObjects as? [Todo]
//        bundleCopy = bundleAll?.filter{ $0.isSelected == true}.filter{$0.isCompleted == false}//.reversed()
        bundleNameTextField.returnKeyType = .done
        bundleTableView.allowsSelection = false
//        NSPredicate
        bundleNameTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
//        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .UIApplicationWillResignActive, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @objc func willResignActive(_ notification: Notification) {
//        completedCounter = 0
//        somethingWasPutBack = 0
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        let bundleAll = currentEvent?.todoArray?.allObjects as? [Todo]
        bundleCopy = bundleAll?.filter{ $0.isSelected == true}.filter{$0.isCompleted == false}.sorted {($0.hasTimeTag?.preposition)! < ($1.hasTimeTag?.preposition)!}
        let nonrepeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == false} ?? []
        let repeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == true} ?? []
        bundleCopy = nonrepeatingCopy + repeatingCopy
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0{
//            return "Single use"
//        } else {
//            return "Repeated reminders"
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard bundleCopy != nil else { return 0 }
//        if section == 0 {
//            return bundleCopy?.filter {$0.isRepeated == false}.count ?? 0
//        } else {
//            return bundleCopy?.filter {$0.isRepeated == true}.count ?? 0
//        }
        return bundleCopy?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chosenTodosTableViewCell", for: indexPath) as! BundleTableViewCell
//        let cellAfter = tableView.dequeueReusableCell(withIdentifier: "chosenTodosTableViewCell", for: indexPath + 1) as! BundleTableViewCell
        cell.checkButton.isSelected = bundleCopy![indexPath.row].isCompleted
        cell.showsReorderControl = true
        //        cell.showsReorderControl = true
//        let nonrepeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == false} ?? []
//        let repeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == true} ?? []
        var todoPlaceholder: Todo
//        if indexPath.section == 0 {
            //            guard nonrepeatingCopy != nil else {return}
//            todoPlaceholder = nonrepeatingCopy[indexPath.row]
            todoPlaceholder = bundleCopy![indexPath.row]
            cell.todoForBundle.text = todoPlaceholder.title
            cell.onButtonTouched = { (cellin) in
                guard let indexPath = tableView.indexPath(for: cellin) else { return }
                print ("button tapped at\(indexPath.row)")
                if todoPlaceholder.isCompleted == false {
                    todoPlaceholder.isCompleted = true
                    cell.checkButton.isSelected = true
                    self.completedCounter += 1
                    print("completed one")
                } else {
                    todoPlaceholder.isCompleted = false
                    cell.checkButton.isSelected = false
                    self.completedCounter -= 1
                    print("uncompleted")
                }
            }
            cell.putBackTouched = { (cellin) in
                guard let indexPath = tableView.indexPath(for: cellin) else { return }
                if todoPlaceholder.isCompleted == true {
                    todoPlaceholder.isCompleted = false
//                    cell.checkButton.isSelected = false
                    self.completedCounter -= 1
                }
                todoPlaceholder.isSelected = false
                let bundleAll = self.currentEvent?.todoArray?.allObjects as? [Todo]
//                self.bundleCopy = bundleAll?.filter{ $0.isSelected == true}.filter{$0.isCompleted == false}
                self.bundleCopy?.remove(at: indexPath.row)
                self.somethingWasPutBack += 1
//                cell.checkButton.isSelected = cellAfter.checkButton.isSelected
            }
//        } else {
//            //            guard repeatingCopy != nil else {return}
//            todoPlaceholder = repeatingCopy[indexPath.row]
//            cell.todoForBundle.text = todoPlaceholder.title
//            cell.onButtonTouched = { (cellin) in
//                guard let indexPath = tableView.indexPath(for: cellin) else { return }
//                print ("button tapped at\(indexPath.row)")
//                if todoPlaceholder.isCompleted == false {
//                    todoPlaceholder.isCompleted = true
//                    cell.checkButton.isSelected = true
//                    self.completedCounter += 1
//                } else {
//                    todoPlaceholder.isCompleted = false
//                    cell.checkButton.isSelected = false
//                    self.completedCounter -= 1
//                }
//            }
//            cell.putBackTouched = { (cellin) in
//                guard let indexPath = tableView.indexPath(for: cellin) else { return }
//                if todoPlaceholder.isCompleted == true {
//                    todoPlaceholder.isCompleted = false
//                    cell.checkButton.isSelected = false
//                    self.completedCounter -= 1
//                }
//                todoPlaceholder.isSelected = false
//                let bundleAll = self.currentEvent?.todoArray?.allObjects as? [Todo]
//                self.bundleCopy = bundleAll?.filter{ $0.isSelected == true}.filter{$0.isCompleted == false}
//                self.somethingWasPutBack += 1
//            }
//        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moved = self.bundleCopy![sourceIndexPath.row]
        bundleCopy?.remove(at: sourceIndexPath.row)
        bundleCopy?.insert(moved, at: destinationIndexPath.row)
//        var nonrepeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == false} ?? []
//        var repeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == true} ?? []
//        if sourceIndexPath.section == 0 {
//            if destinationIndexPath.section == 0 {
//                //same, nonrepeating
//                let moved = nonrepeatingCopy[sourceIndexPath.row]
//                nonrepeatingCopy.remove(at: sourceIndexPath.row)
//                nonrepeatingCopy.insert(moved, at: destinationIndexPath.row)
//            } else {
//                // non->re
//                let moved = nonrepeatingCopy[sourceIndexPath.row]
//                nonrepeatingCopy.remove(at: sourceIndexPath.row)
//                repeatingCopy.insert(moved, at: destinationIndexPath.row)
//            }
//        } else {
//            if destinationIndexPath.section == 0 {
//                //re->non
//                let moved = repeatingCopy[sourceIndexPath.row]
//                repeatingCopy.remove(at: sourceIndexPath.row)
//                nonrepeatingCopy.insert(moved, at: destinationIndexPath.row)
//            } else {
//                // same, re
//                let moved = repeatingCopy[sourceIndexPath.row]
//                repeatingCopy.remove(at: sourceIndexPath.row)
//                repeatingCopy.insert(moved, at: destinationIndexPath.row)
//            }
//        }
//        bundleTableView.reloadData()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        bundleNameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func attemptToCompleteButtonTapped(_ sender: UIButton) {
        if completedCounter == bundleCopy?.count {
            if bundleNameTextField.text == "" {
                let popOver = UIStoryboard(name: "Checkin", bundle: nil).instantiateViewController(withIdentifier: "NameYourBundle") as! BundleNamingPromtViewController
                self.addChildViewController(popOver)
                popOver.view.frame = self.view.frame
                self.view.addSubview(popOver.view)
                //                let (canMakeIt, cantMakeIt) = CalculateTime.findNames(time: indexPath.row, names: names)
                //                print(canMakeIt)
                //                print(cantMakeIt)
                //                popOver.canMakeNamesLabel.text = canMakeIt
                //                popOver.cannotMakeNamesLabel.text = cantMakeIt
                popOver.didMove(toParentViewController: self)
            } else {
                performSegue(withIdentifier: "bundleCompleted", sender: Any?.self)
            }
        } else {
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "bundleAbandoned":
            for i in bundleCopy! {
//                i.isSelected = false
                i.isCompleted = false
            }
            if somethingWasPutBack > 0 {
                let destination = segue.destination as! TodoChoiceViewController
                destination.selectionCounter -= somethingWasPutBack
//                destination.choiceTableView.reloadData()
            }
            CoreDataHelper.save()
        case "bundleCompleted":
            let newBundle = CoreDataHelper.newBundle()
            //FIXME: resourse on save sessions!
                //.objectID.uriRepresentation().absoluteString
            newBundle.name = bundleNameTextField.text
            newBundle.dateCompleted = Date()
            currentEvent?.addToBundleArray(newBundle)
//            let nonrepeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == false} ?? []
//            let repeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == true} ?? []
            for i in bundleCopy! {
                if i.isRepeated {
                    let duplicate = CoreDataHelper.newTodo()
                    duplicate.isRepeated = false
                    duplicate.isCompleted = true
                    duplicate.isSelected = false
                    duplicate.title = i.title
                    duplicate.hasTimeTag = i.hasTimeTag
                    duplicate.belongToEvent = i.belongToEvent
                    newBundle.addToContainsTodos(duplicate)
                    i.isSelected = false
                    i.isCompleted = false
                    CoreDataHelper.save()
                } else {
                    i.isSelected = false
                    newBundle.addToContainsTodos(i)
                    CoreDataHelper.save()
                }
            }
//            for i in nonrepeatingCopy {
//                i.isSelected = false
//                newBundle.addToContainsTodos(i)
//            }
//            for i in repeatingCopy {
//                let duplicate = CoreDataHelper.newTodo()
//                duplicate.isRepeated = false
//                duplicate.isCompleted = true
//                duplicate.isSelected = false
//                duplicate.title = i.title
//                duplicate.hasTimeTag = i.hasTimeTag
//                duplicate.belongToEvent = i.belongToEvent
//                newBundle.addToContainsTodos(duplicate)
//                i.isSelected = false
//                i.isCompleted = false
//            }
//            CoreDataHelper.save()
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

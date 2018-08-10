//
//  BundleViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit
import Crashlytics

class BundleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var bundleCopy: [Todo]? = nil {
        didSet {
            bundleTableView.reloadData()
        }
    }
    var currentEvent: Event?
    var completedCounter: Int = 0
    var somethingWasPutBack = 0
    var reloadCounter = 0
    @IBOutlet weak var bundleNameTextField: UITextField!

    @IBOutlet weak var bundleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        bundleTableView.delegate = self
        bundleTableView.dataSource = self
        bundleTableView.allowsMultipleSelection = true
        bundleTableView.isEditing = true
        
        bundleNameTextField.returnKeyType = .done
        bundleTableView.allowsSelection = false

        bundleNameTextField.delegate = self
        bundleNameTextField.attributedPlaceholder = NSAttributedString(string: "Give your bundle a name!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.underlineColor: UIColor.SummerSkyBlue])
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        let bundleAll = currentEvent?.todoArray?.allObjects as? [Todo]
        bundleCopy = bundleAll?.filter{ $0.isSelected == true}.filter{$0.isCompleted == false}.sorted {($0.hasTimeTag?.preposition)! < ($1.hasTimeTag?.preposition)!}
        let nonrepeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == false} ?? []
        let repeatingCopy: [Todo] = bundleCopy?.filter {$0.isRepeated == true} ?? []
        bundleCopy = nonrepeatingCopy + repeatingCopy
        //FIXME: save a session in UserDefaults. --save the bundle itself, and call upon the id in userdefaults to ask if the user wants to return to that page
//        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .UIApplicationWillResignActive, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bundleCopy?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chosenTodosTableViewCell", for: indexPath) as! BundleTableViewCell
        cell.checkButton.isSelected = bundleCopy![indexPath.row].isCompleted
        cell.showsReorderControl = true
        var todoPlaceholder: Todo
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
                    self.completedCounter -= 1
                }
                todoPlaceholder.isSelected = false
                self.bundleCopy?.remove(at: indexPath.row)
                self.somethingWasPutBack += 1
                if self.bundleCopy?.count == 0 {
                    self.performSegue(withIdentifier: "bundleAbandoned", sender: Any?.self)
                }
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if reloadCounter == 0 {
            bundleTableView.reloadData()
            reloadCounter += 1
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moved = self.bundleCopy![sourceIndexPath.row]
        bundleCopy?.remove(at: sourceIndexPath.row)
        
        bundleCopy?.insert(moved, at: destinationIndexPath.row)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        bundleNameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func attemptToCompleteButtonTapped(_ sender: UIButton) {
        if completedCounter == bundleCopy?.count {
            if bundleNameTextField.text == "" {
//                Answers.logCustomEvent(withName: "bundle unnamed", customAttributes: ["Tag":"Work-around", "Flow": "Checkin", "Controller":"Bundle"])
                let popOver = UIStoryboard(name: "Checkin", bundle: nil).instantiateViewController(withIdentifier: "NameYourBundle") as! BundleNamingPromtViewController
                self.addChildViewController(popOver)
                popOver.view.frame = self.view.frame
                self.view.addSubview(popOver.view)
                popOver.didMove(toParentViewController: self)
            } else {
//                Answers.logCustomEvent(withName: "Checkin flow completed", customAttributes: ["Category":"Core flow checkin", "Tag":"Expected", "Flow": "Checkin", "Controller":"Bundle"])
                performSegue(withIdentifier: "bundleCompleted", sender: Any?.self)
            }
        } else {
//            Answers.logCustomEvent(withName: "bundle uncompleted", customAttributes: ["Tag":"Work-around", "Flow": "Checkin", "Controller":"Bundle"])
            let popOver = UIStoryboard(name: "Checkin", bundle: nil).instantiateViewController(withIdentifier: "CompleteYourBundle") as! BundleNamingPromtViewController
            self.addChildViewController(popOver)
            popOver.view.frame = self.view.frame
            self.view.addSubview(popOver.view)
            popOver.didMove(toParentViewController: self)
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "bundleAbandoned":
//            Answers.logCustomEvent(withName: "quit bundle", customAttributes: ["Funnel":"Cancel", "Flow": "Checkin", "Controller":"Bundle"])
            for i in bundleCopy! {
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
        default:
            print ("failed to pass data")
        }
    }
}

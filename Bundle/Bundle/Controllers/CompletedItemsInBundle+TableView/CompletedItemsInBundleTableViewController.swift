//
//  CompletedItemsInBundleTableViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/8/1.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit
import Crashlytics

class CompletedItemsInBundleTableViewController: UITableViewController {

    @IBOutlet weak var backToListOfBundles: UIBarButtonItem!
    
    var tasks: [Todo]! {
        didSet{
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tasks = tasks.sorted{($0.hasTimeTag?.preposition)! < ($1.hasTimeTag?.preposition)!}
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationController?.navigationBar.barTintColor = UIColor.SummerSkyBlue
//        Answers.logCustomEvent(withName: "Review flow completed", customAttributes: ["Category":"Core flow review", "Flow": "Review", "Controller":"CompletedItems"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskInBundleReview", for: indexPath) as! CompletedItemsInBundleTableViewCell
        cell.taskTitleLabel.text = tasks[indexPath.row].title
        cell.timeTag.text = tagToString(tasks[indexPath.row].hasTimeTag!)
        cell.timeTag.layer.cornerRadius = 3
        cell.timeTag.layer.masksToBounds = true
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let todoToDelete = tasks![indexPath.row]
            CoreDataHelper.deleteTodo(todo: todoToDelete)
            tasks.remove(at: indexPath.row)
//            let allTodo = currentEvent?.todoArray?.allObjects as? [Todo]
//            accessTodo = allTodo?.filter{$0.isCompleted == false}
            //            accessTodo = CoreDataHelper.retrieveAllTodo()
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
//        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    

}

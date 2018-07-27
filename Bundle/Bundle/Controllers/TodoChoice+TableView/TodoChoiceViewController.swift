//
//  TodoChoiceViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit
class TodoChoiceViewController: UIViewController/*, UITableViewDataSource, UITableViewDelegate*/ {

    var currentEvent: Event?
    
    @IBOutlet weak var choiceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return currentEvent?.todoArray?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! TodoChoiceTableViewCell
////        let accessTodo = currentEvent?.todoArray
////        cell.todoForEvent.text = accessTodo![indexPath.row].title
//////        cell.notePreview.text = accessnote.content
//////        cell.noteModificationTimeLabel.text = accessnote.modificationTime?.convertToString() ?? "unknown"
////
////
////        return cell
//    }
    

}

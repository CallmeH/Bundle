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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let bundle = bundleCopy else { return 0 }
        return bundle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chosenTodosTableViewCell", for: indexPath) as! BundleTableViewCell
        cell.showsReorderControl = true
        cell.todoForBundle.text = bundleCopy![indexPath.row].title
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

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
//            cell.accessoryType = .
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        func initializeNewBundle() {
            guard let indexPaths = bundleTableView.indexPathForSelectedRow else { return }
            
            
            //            setTodo.belongToEvent = EventPlaceholder
        }
        switch identifier {
        case "bundleCompleted":
            let destination = segue.destination as! HomeViewController
//            destination.currentEvent = currentEvent
        //            destination.bundleCopy = accessTodo!.filter { $0.isCompleted == true } as! BundledTodo
        default:
            print ("failed to pass data from todochoice to bundle")
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

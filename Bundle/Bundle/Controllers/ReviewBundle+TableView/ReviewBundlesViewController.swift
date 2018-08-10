//
//  ReviewBundlesViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/31.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit
import Crashlytics

class ReviewBundlesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBAction func sortingOption(_ sender: UISegmentedControl) {
        switch sortSegmentedControl.selectedSegmentIndex {
        case Constant.ReviewBundleSortingOptions.time:
            completedBundlesTableView.reloadData()
        case Constant.ReviewBundleSortingOptions.event:
            completedBundlesTableView.reloadData()
        default:
            print("no change")
        }
    }
    @IBOutlet weak var completedBundlesTableView: UITableView!
    
    var bundles: [Bundle]?
    var events: [Event]?
    var day: [Bundle]?
    var week: [Bundle]?
    var month: [Bundle]?
    var year: [Bundle]?
    var moreThanAYear: [Bundle]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completedBundlesTableView.delegate = self
        completedBundlesTableView.dataSource = self
        completedBundlesTableView.allowsSelection = true
        bundles = CoreDataHelper.retrieveAllBundle()
        events = CoreDataHelper.retrieveAllEvent().filter{$0.bundleArray != []}
        
        day = bundles?.filter{($0.dateCompleted?.isInToday)!}.sorted(by: { $0.dateCompleted! > $1.dateCompleted!})
        week = bundles?.filter{($0.dateCompleted?.isInThisWeek)!}.filter{$0.dateCompleted?.isInToday == false}.sorted(by: { $0.dateCompleted! > $1.dateCompleted!})
        month = bundles?.filter{$0.dateCompleted?.isInThisMonth ?? false}.filter{($0.dateCompleted?.isInThisWeek)! == false}.filter{$0.dateCompleted?.isInToday == false}.sorted(by: { $0.dateCompleted! > $1.dateCompleted!})
        year = bundles?.filter{($0.dateCompleted?.isInThisYear)! }.filter{($0.dateCompleted?.isInThisMonth)! == false}.filter{($0.dateCompleted?.isInThisWeek)! == false}.filter{($0.dateCompleted?.isInToday)!}.sorted(by: { $0.dateCompleted! > $1.dateCompleted!})
        moreThanAYear = bundles?.filter{$0.dateCompleted?.isInThisYear == false}.sorted(by: { $0.dateCompleted! > $1.dateCompleted!})
        
        navigationController?.navigationBar.barTintColor = UIColor.SummerSkyBlue
//        Answers.logCustomEvent(withName: "land on review", customAttributes: ["Funnel":"fresh review", "Flow": "Review", "Controller":"ReviewBundles"])
//        completedBundlesTableView.allowsSelection = false
//        print(bundles)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sortSegmentedControl.selectedSegmentIndex == Constant.ReviewBundleSortingOptions.time {
            return 5
            // today, this week, this month, this year, longer than a year ago
        } else {
            return events!.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortSegmentedControl.selectedSegmentIndex == Constant.ReviewBundleSortingOptions.time {
            switch section {
            case 0:
                return day?.count ?? 0
            case 1:
                return week?.count ?? 0
            case 2:
                return month?.count ?? 0
            case 3:
                return year?.count ?? 0
            default:
                return moreThanAYear?.count ?? 0
            }
        } else {
            for i in 0...(events?.count)!-1 {
                if section == i {
                    return events![i].bundleArray?.allObjects.count ?? 0
                }
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sortSegmentedControl.selectedSegmentIndex == Constant.ReviewBundleSortingOptions.time {
            switch section {
            case 0:
                return "Today"
            case 1:
                return "This week"
            case 2:
                return "This month"
            case 3:
                return "This year"
            case 4:
                return "More than a year ago"
            default:
                return "Undefined time"
            }
        } else {
            for i in 0...(events?.count)!-1 {
                if section == i {
                    return events![i].name
                }
            }
            return "undefined"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bundleReview", for: indexPath) as! ReviewBundlesTableViewCell
        var bundlesPlaceholder: Bundle
        
        func setCell() {
            cell.bundleNameLabel.text = bundlesPlaceholder.name
            cell.eventInitialsLabel.layer.cornerRadius = 3
            cell.eventInitialsLabel.layer.masksToBounds = true
            if sortSegmentedControl.selectedSegmentIndex == Constant.ReviewBundleSortingOptions.time {
                cell.eventInitialsLabel.isHidden = false
                cell.eventInitialsLabel.text = " " + (bundlesPlaceholder.belongToEvent?.name)! + " "
            } else {
                cell.eventInitialsLabel.text = ""
                cell.eventInitialsLabel.isHidden = true
            }
            if (bundlesPlaceholder.dateCompleted?.isInToday)! {
                cell.timeStampLabel.text = bundlesPlaceholder.dateCompleted?.convertToStringToday()
            } else {
                if (bundlesPlaceholder.dateCompleted?.isInThisYear)! {
                    cell.timeStampLabel.text = bundlesPlaceholder.dateCompleted?.convertToString()
                } else {
                    cell.timeStampLabel.text = bundlesPlaceholder.dateCompleted?.convertToStringIncludeYear()
                }
            }
        }
        if sortSegmentedControl.selectedSegmentIndex == Constant.ReviewBundleSortingOptions.time {
            switch indexPath.section {
            case 0:
                bundlesPlaceholder = day![indexPath.row]
                setCell()
            case 1:
                bundlesPlaceholder = week![indexPath.row]
                setCell()
            case 2:
                bundlesPlaceholder = month![indexPath.row]
                setCell()
            case 3:
                bundlesPlaceholder = year![indexPath.row]
                setCell()
            default:
                bundlesPlaceholder = moreThanAYear![indexPath.row]
                setCell()
            }
        } else {
            for i in 0...numberOfSections(in: completedBundlesTableView)-1 {
                if indexPath.section == i {
                    bundlesPlaceholder = events![i].bundleArray?.allObjects[indexPath.row] as! Bundle
                    setCell()
                }
            }
        }
        return cell
    }
    
//    FIXME: add delete function
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let bundleToDelete = accessTodo![indexPath.row]
//            CoreDataHelper.deleteTodo(todo: todoToDelete)
//            let allTodo = currentEvent?.todoArray?.allObjects as? [Todo]
//            accessTodo = allTodo?.filter{$0.isCompleted == false}
//            //            accessTodo = CoreDataHelper.retrieveAllTodo()
//            tableView.reloadData()
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "bundleReviewToTasks":
//            Answers.logCustomEvent(withName: "see bundle details", customAttributes: ["Funnel":"review->completed", "Flow": "Review", "Controller":"CompletedItems"])
            guard let indexPath = completedBundlesTableView.indexPathForSelectedRow else {return}
            var chosenBundle: Bundle?
            let destination = segue.destination as! CompletedItemsInBundleTableViewController
            if sortSegmentedControl.selectedSegmentIndex == Constant.ReviewBundleSortingOptions.time {
                switch indexPath.section {
                case 0:
                    chosenBundle = day![indexPath.row]
                case 1:
                    chosenBundle = week![indexPath.row]
                case 2:
                    chosenBundle = month![indexPath.row]
                case 3:
                    chosenBundle = year![indexPath.row]
                case 4:
                    chosenBundle = moreThanAYear![indexPath.row]
                default:
                    print("In Time section, something went wrong")
                }
            } else {
                for i in 0...numberOfSections(in: completedBundlesTableView)-1 {
                    if indexPath.section == i {
                        chosenBundle = events![i].bundleArray?.allObjects[indexPath.row] as? Bundle
                    }
                }
            }
            guard chosenBundle != nil else {
                print ("bundle choice unsuccessful")
                return
            }
            destination.tasks = chosenBundle?.containsTodos?.allObjects as! [Todo]
            let nextPageTitle = chosenBundle?.name ?? "Back"
            destination.backToListOfBundles.title = "< \(nextPageTitle)"
        default:
            print("doesn't work")
        }
    }
    
    @IBAction func unwindToReviewBundle(_ segue: UIStoryboardSegue) {
    }

}

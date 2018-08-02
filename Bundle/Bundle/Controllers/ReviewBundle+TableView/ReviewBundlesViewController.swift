//
//  ReviewBundlesViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/31.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completedBundlesTableView.delegate = self
        completedBundlesTableView.dataSource = self
        bundles = CoreDataHelper.retrieveAllBundle()
        events = CoreDataHelper.retrieveAllEvent().filter{$0.todoArray != []}
        
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
            //            return CoreDataHelper.retrieveAllEvent().filter({ (event: Event) -> Bool in
            //                guard event.todoArray == [] else { return true }
            //                return false
            //            }).count
            return events!.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortSegmentedControl.selectedSegmentIndex == Constant.ReviewBundleSortingOptions.time {
            switch section {
            case 0:
                return bundles?.filter({ (bundle: Bundle) -> Bool in
                    bundle.dateCompleted?.isInToday ?? false
                }).count ?? 0
            case 1:
                return bundles?.filter({ (bundle: Bundle) -> Bool in
                    bundle.dateCompleted?.isInThisWeek ?? false
                }).count ?? 0
            case 2:
                return bundles?.filter({ (bundle: Bundle) -> Bool in
                    bundle.dateCompleted?.isInThisMonth ?? false
                }).count ?? 0
            case 3:
                return bundles?.filter({ (bundle: Bundle) -> Bool in
                    bundle.dateCompleted?.isInThisYear ?? false
                }).count ?? 0
            default:
                return bundles?.filter({ (bundle: Bundle) -> Bool in
                    !(bundle.dateCompleted?.isInThisYear ?? false)
                }).count ?? 0
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
                return "Longer than a year ago"
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
        func setCellExceptForToday() {
            cell.bundleNameLabel.text = bundlesPlaceholder.name
            cell.eventInitialsLabel.text = bundlesPlaceholder.belongToEvent?.name
            cell.timeStampLabel.text = bundlesPlaceholder.dateCompleted?.convertToString()
        }
        if sortSegmentedControl.selectedSegmentIndex == Constant.ReviewBundleSortingOptions.time {
            switch indexPath.section {
            case 0:
                bundlesPlaceholder = (bundles?.filter({ (bundle: Bundle) -> Bool in
                    bundle.dateCompleted?.isInToday ?? false
                })[indexPath.row])!
                cell.bundleNameLabel.text = bundlesPlaceholder.name
                cell.eventInitialsLabel.text = bundlesPlaceholder.belongToEvent?.name
                cell.timeStampLabel.text = bundlesPlaceholder.dateCompleted?.convertToStringToday()
            case 1:
                bundlesPlaceholder = (bundles?.filter({ (bundle: Bundle) -> Bool in
                    bundle.dateCompleted?.isInThisWeek ?? false
                })[indexPath.row])!
                setCellExceptForToday()
            case 2:
                bundlesPlaceholder = (bundles?.filter({ (bundle: Bundle) -> Bool in
                    bundle.dateCompleted?.isInThisMonth ?? false
                })[indexPath.row])!
                setCellExceptForToday()
            case 3:
                bundlesPlaceholder = (bundles?.filter({ (bundle: Bundle) -> Bool in
                    bundle.dateCompleted?.isInThisYear ?? false
                })[indexPath.row])!
                setCellExceptForToday()
            default:
                bundlesPlaceholder = (bundles?.filter({ (bundle: Bundle) -> Bool in
                    !(bundle.dateCompleted?.isInThisYear ?? false)
                })[indexPath.row])!
                setCellExceptForToday()
            }
        } else {
            for i in 0...numberOfSections(in: completedBundlesTableView)-1 {
                if indexPath.section == i {
                    bundlesPlaceholder = events![i].bundleArray?.allObjects[indexPath.row] as! Bundle
                    setCellExceptForToday()
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "bundleReviewToTasks":
            guard let indexPath = completedBundlesTableView.indexPathForSelectedRow else {return}
            let chosenBundle: Bundle = bundles![indexPath.row]
            let destination = segue.destination as! CompletedItemsInBundleTableViewController
            destination.tasks = chosenBundle.containsTodos?.allObjects as! [Todo]
        default:
            print("doesn't work")
        }
    }

}

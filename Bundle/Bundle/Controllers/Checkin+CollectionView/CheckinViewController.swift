//
//  CheckinViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

class CheckinViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var allEvents = [Event]() {
        didSet {
            CheckinCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCellCheckin", for: indexPath) as! CheckinCollectionViewCell
        let event = allEvents[indexPath.item]
        cell.layer.cornerRadius = 3
        cell.layer.masksToBounds = true
        cell.eventTagCheckin.text = event.name
        cell.backgroundColor = .LightGrey
        cell.eventTagCheckin.textColor = UIColor.BlueGrey
        return cell
    }
    
    @IBOutlet weak var CheckinCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let completedAndUncompleted = CoreDataHelper.retrieveAllEvent()
        allEvents = completedAndUncompleted.filter{$0.todoArray != []}

        CheckinCollectionView.delegate = self
        CheckinCollectionView.dataSource = self
        
        CheckinCollectionView.allowsSelection = true
        // Do any additional setup after loading the view.
        presetCollectionViewLayout(in: CheckinCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CheckinCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let indexPath = CheckinCollectionView.indexPathsForSelectedItems else {return}
        let selectedEvent = allEvents[indexPath[0].item]
        let Todos = selectedEvent.todoArray?.allObjects as! [Todo]
        let uncompletedTodos = Todos.filter{$0.isCompleted == false}
        if uncompletedTodos == [] {
//            performSegue(withIdentifier: "chosenInvalidEvent", sender: Any?.self)
            let popOver = UIStoryboard(name: "Checkin", bundle: nil).instantiateViewController(withIdentifier: "YouAreAllClear") as! BundleNamingPromtViewController
            self.addChildViewController(popOver)
            popOver.view.frame = self.view.frame
            self.view.addSubview(popOver.view)
            popOver.didMove(toParentViewController: self)
        } else {
            performSegue(withIdentifier: "chosenValidEvent", sender: Any?.self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "chosenValidEvent":
            guard let indexPath = CheckinCollectionView.indexPathsForSelectedItems else { return }
            guard indexPath.count == 1 else {return}
            let selectedEvent = allEvents[indexPath[0].item]
            let destination = segue.destination as! TodoChoiceViewController
            destination.currentEvent = selectedEvent
        case "chosenInvalidEvent":
//            guard let indexPath = CheckinCollectionView.indexPathsForSelectedItems else {return}
//            let selectedEvent = allEvents[indexPath[0].item]
//            let destination
            print("all clear")
        default:
            return
        }
    }
    
    @IBAction func unwindToCheckin(_ segue: UIStoryboardSegue) {
        let completedAndUncompleted = CoreDataHelper.retrieveAllEvent()
        allEvents = completedAndUncompleted.filter{$0.todoArray != []}
    }

}

extension CheckinViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = allEvents[indexPath.item].name?.size(withAttributes: [.font: UIFont.systemFont(ofSize: 20.0)])
//        print(size)
        
        var adjustedSize = CGSize(width: size?.width ?? 40 + 40, height: size?.height ?? 15 + 20)
        if adjustedSize.width > 0.95 * CheckinCollectionView.frame.width {
            adjustedSize.height *= CGFloat(Int(adjustedSize.width/(0.95 * CheckinCollectionView.frame.width)) + 1)
            adjustedSize.width = 0.95 * CheckinCollectionView.frame.width
            return adjustedSize
        } else {
            return adjustedSize
        }
    }
    
}

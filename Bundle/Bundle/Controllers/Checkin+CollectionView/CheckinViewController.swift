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
        cell.eventTagCheckin.text = event.name
        cell.backgroundColor = .lightGray
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // before/when/after
    @IBOutlet weak var prepositionDisplayLabel: UILabel!
    //    var prepositionStatus: String = prepType.when.displayName
    var prepositionStatus: prepType = .before
    //    var prepositionStatus: String? = nil
    @IBOutlet weak var prepositionChoice: UISegmentedControl!
    @IBAction func prepositionTapped(_ sender: UISegmentedControl) {
        switch prepositionChoice.selectedSegmentIndex {
        case 0:
            prepositionStatus = .before
            self.prepositionDisplayLabel.text = "I'm preparing to"
        case 1:
            prepositionStatus = .when
            self.prepositionDisplayLabel.text = "I'm about to..."
        case 2:
            prepositionStatus = .after
            self.prepositionDisplayLabel.text = "I just finished..."
        default:
            print("no change")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let indexPath = CheckinCollectionView.indexPathsForSelectedItems else {return}
        let selectedEvent = allEvents[indexPath[0].item]
        let Todos = selectedEvent.todoArray?.allObjects as! [Todo]
        let uncompletedTodos = Todos.filter{$0.isCompleted == false}
        if uncompletedTodos == [] {
            performSegue(withIdentifier: "chosenInvalidEvent", sender: Any?.self)
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

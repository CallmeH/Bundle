//
//  AddEventViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/8/2.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

class AddEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var addToEventsCollectionView: UICollectionView!
    @IBOutlet weak var inputEventTextField: UITextField!
    
    var allEvents = [Event]() {
        didSet {
            addToEventsCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allEvents = CoreDataHelper.retrieveAllEvent()
        
        addToEventsCollectionView.delegate = self
        addToEventsCollectionView.dataSource = self
        addToEventsCollectionView.allowsSelection = true
        addToEventsCollectionView.allowsMultipleSelection = true
        presetCollectionViewLayout(in: addToEventsCollectionView)
        
        inputEventTextField.delegate = self
        inputEventTextField.returnKeyType = .done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        inputEventTextField.resignFirstResponder()
        guard inputEventTextField.text != "" else { return true }
        let newEvent = CoreDataHelper.newEvent()
        newEvent.name = inputEventTextField.text
//        newEvent.isPinned = false
        newEvent.bundleArray = []
        
        CoreDataHelper.save()
        inputEventTextField.text = ""
        allEvents = CoreDataHelper.retrieveAllEvent()
        return true
    }
    
    @IBAction func assignEventButtonTapped(_ sender: UIButton) {
        guard addToEventsCollectionView.indexPathsForSelectedItems != [] else {
            print("\n\n\n no selection \n\n\n")
            return
        }
        guard addToEventsCollectionView.indexPathsForSelectedItems != nil else {
            print("\n\n\n no selection \n\n\n")
            return
        }
        performSegue(withIdentifier: "EventsAssigned", sender: Any?.self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        if indexPath.row == self.allEvents.count {
        //            // use prototype cell with button
        //        } else {
        //
        //        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleEventChoiceCell", for: indexPath) as! EventTagsCollectionViewCell
        let event = allEvents[indexPath.item]
        cell.eventTag.text = event.name
        cell.backgroundColor = .lightGray
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "EventsAssigned":
            let destination = segue.destination as! AddFirstScreenViewController
            guard let indexPaths = addToEventsCollectionView.indexPathsForSelectedItems else { return }
            print("event assigned! to events: \(String(describing: addToEventsCollectionView.indexPathsForSelectedItems))")
            //print to see what allEvents contain and make sure it should've been [0][1]
//            let selectedEvent = allEvents[indexPaths[0][1]]
//            destination.selectedEvent = selectedEvent
            var selectedEvents = [Event]()
            for (index, _) in indexPaths.enumerated() {
                selectedEvents.append(allEvents[indexPaths[index][1]])
            }
            destination.selectedEvent = selectedEvents
            destination.eventWasSetBefore = true
        default:
            print("unidentified segue")
        }
    }
    
}


extension AddEventViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = allEvents[indexPath.item].name?.size(withAttributes: [.font: UIFont.systemFont(ofSize: 20.0)])
        
        var adjustedSize = CGSize(width: (size?.width) ?? 40 + 40, height: size?.height ?? 15 + 20)
        if adjustedSize.width > 0.95 * addToEventsCollectionView.frame.width {
            adjustedSize.height *= CGFloat(Int(adjustedSize.width/(0.95 * addToEventsCollectionView.frame.width)) + 1)
            adjustedSize.width = 0.95 * addToEventsCollectionView.frame.width
            return adjustedSize
        } else {
            return adjustedSize
        }
    }
    
}

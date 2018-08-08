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
    
    var previouslySelectedEvents = [Event]()
    
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
        inputEventTextField.attributedPlaceholder = NSAttributedString(string: "Didn't see your event?", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.underlineColor: UIColor.SummerSkyBlue])
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initiateNewEvent() {
        inputEventTextField.resignFirstResponder()
        guard inputEventTextField.text != "" else { return }
        func checkDuplicate() -> Bool {
            for i in allEvents {
                if inputEventTextField.text == i.name {
                    print("duplicate event name")
                    return false
                }
            }
            return true
        }
        guard checkDuplicate() else {
            //FIXME: do something to call a pop up window saying: "Oops, there's another event with the same name."
            return
        }
        var eventLongEnoughTitle: String = inputEventTextField.text!
        while eventLongEnoughTitle.count < 5 {
            eventLongEnoughTitle += " "
        }
        let newEvent = CoreDataHelper.newEvent()
        newEvent.name = eventLongEnoughTitle
        //        newEvent.isPinned = false
        newEvent.bundleArray = []
        
        CoreDataHelper.save()
        //save previously selected events
        let indexPaths = addToEventsCollectionView.indexPathsForSelectedItems
        if indexPaths != nil {
            var temporarySelection = [Event]()
            for (index, _) in (indexPaths?.enumerated())! {
                temporarySelection.append(allEvents[indexPaths![index][1]])
            }
            previouslySelectedEvents = temporarySelection
        }
        //
        inputEventTextField.text = ""
        allEvents = CoreDataHelper.retrieveAllEvent()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        initiateNewEvent()
        return true
    }
    
    @IBAction func addNewEventButtonTouched(_ sender: UIButton) {
        initiateNewEvent()
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
        cell.layer.cornerRadius = 3
        cell.layer.masksToBounds = true
        cell.eventTag.text = event.name
        cell.backgroundColor = UIColor.DarkGrey
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.AlmostWhite.cgColor
        cell.eventTag.textColor = UIColor.LightGrey
        for i in previouslySelectedEvents {
            //FIXME: don't let it be based on i.name, change it to be based on objectID in coredata
            if event.name == i.name {
                cell.isSelected = true
                addToEventsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                //save to previously selected list
//                previouslySelectedEvents.append(i)
            }
        }
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

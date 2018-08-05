//
//  AssignToEventViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout
//import TagCellLayout
class AssignToEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var prepositionDisplayLabel: UILabel!
    @IBOutlet weak var selectEventsCollectionView: UICollectionView!
    @IBOutlet weak var inputEventNameTextField: UITextField!
    
    var todoAtAssign: Todo?
    
    var allEvents = [Event]() {
        didSet {
            selectEventsCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allEvents = CoreDataHelper.retrieveAllEvent()

        selectEventsCollectionView.delegate = self
        selectEventsCollectionView.dataSource = self
        
        selectEventsCollectionView.allowsMultipleSelection = true
//        let cellNib = UINib(nibName: "EventTagsCollectionViewCell", bundle: nil)
//        self.collectionView.registerNib(cellNib, forCellWithReuseIdentifier: "tagCell")
//        self.collectionView.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
        self.prepositionDisplayLabel.text = prepositionStatus.displayName
        prepositionChoice.selectedSegmentIndex = Int(prepositionStatus.rawValue)
        presetCollectionViewLayout(in: selectEventsCollectionView)
//        self.collectionVie
//        let tagCellLayout = TagCellLayout(alignment: .center, delegate: self as? TagCellLayoutDelegate)
//        selectEventsCollectionView.collectionViewLayout = tagCellLayout
        
//        print(todoAtAssign?.title)
//        print(todoAtAssign?.isRecycled)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inputEventNameTextField.delegate = self
        inputEventNameTextField.returnKeyType = .done
        self.inputEventNameTextField.textColor = UIColor.brown//UIColor(red: 238, green: 238, blue: 238, alpha: 1)
    }
    
//    func textField(_ textField: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if (text == "\n") {
//            textField.resignFirstResponder()
//            guard inputEventNameTextField.text != "" else { return true }
//            let newEvent = CoreDataHelper.newEvent()
//            newEvent.name = inputEventNameTextField.text
//            CoreDataHelper.save()
//        }
//        return true
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        inputEventNameTextField.resignFirstResponder()
        guard inputEventNameTextField.text != "" else { return true }
        let newEvent = CoreDataHelper.newEvent()
        newEvent.name = inputEventNameTextField.text
        CoreDataHelper.save()
        inputEventNameTextField.text = ""
        allEvents = CoreDataHelper.retrieveAllEvent()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // before/when/after
    //    var prepositionStatus: String = prepType.when.displayName
    var prepositionStatus: prepType = .before
    //    var prepositionStatus: String? = nil
    @IBOutlet weak var prepositionChoice: UISegmentedControl!
    @IBAction func prepositionTapped(_ sender: UISegmentedControl) {
        switch prepositionChoice.selectedSegmentIndex {
        case 0:
            prepositionStatus = .before
            self.prepositionDisplayLabel.text = prepType.before.displayName
        case 1:
            prepositionStatus = .when
            self.prepositionDisplayLabel.text = prepType.when.displayName
        case 2:
            prepositionStatus = .after
            self.prepositionDisplayLabel.text = prepType.after.displayName
        default:
            print("no change")
        }
    }
    
    
    //collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.row == self.allEvents.count {
//            // use prototype cell with button
//        } else {
//            
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! EventTagsCollectionViewCell
        let event = allEvents[indexPath.item]
        cell.eventTag.text = event.name
        cell.backgroundColor = .lightGray
        return cell
    }
    

    
    
//    func placeholderCellTappedSegueBack {
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func tryToCompleteButton(_ sender: UIButton) {
        guard selectEventsCollectionView.indexPathsForSelectedItems != [] else {
            print("\n\n\n no selection \n\n\n")
            return
        }
        guard selectEventsCollectionView.indexPathsForSelectedItems != nil else {
            print("\n\n\n no selection \n\n\n")
            return
        }
        performSegue(withIdentifier: "eventsAssigned", sender: Any?.self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        func initializeNewTodo() {
            guard let indexPaths = selectEventsCollectionView.indexPathsForSelectedItems else { return }
            for (index, _) in indexPaths.enumerated() {
                let setTodo = CoreDataHelper.newTodo()
                setTodo.title = (todoAtAssign?.title)!
                setTodo.isRepeated = (todoAtAssign?.isRepeated)!
//                setTodo.belongToEvent = allEvents[i.item]
                setTodo.isCompleted = false
                setTodo.isSelected = false
                let selectedIndex = indexPaths[index]
                let selectedEvent = allEvents[selectedIndex[1]]
                selectedEvent.addToTodoArray(setTodo)
                CoreDataHelper.save()
            }
          
//            setTodo.belongToEvent = EventPlaceholder
        }
//        if segue.identifier == "eventAssigned" {
//            guard selectEventsCollectionView.indexPathsForSelectedItems != [] else {
//                print("\n\n\n no selection \n\n\n")
//                return
//            }
//            guard selectEventsCollectionView.indexPathsForSelectedItems != nil else {
//                print("\n\n\n no selection \n\n\n")
//                return
//            }
//            print("event assigned to events: \(selectEventsCollectionView.indexPathsForSelectedItems)")
//            initializeNewTodo()
//        }
        switch identifier {
        case "AssigntoInput":
            inputEventNameTextField.resignFirstResponder()
            print("going back from assign to input")
        case "eventsAssigned":
            print("event assigned! to events: \(selectEventsCollectionView.indexPathsForSelectedItems)")
            initializeNewTodo()
        case "addingCanceled":
            print("adding process canceled")
        default:
            print("unidentified segue")
        }
    }
}

extension AssignToEventViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = allEvents[indexPath.item].name?.size(withAttributes: [.font: UIFont.systemFont(ofSize: 20.0)])
//        print(size)
        
        let adjustedSize = CGSize(width: (size?.width) ?? 40 + 40, height: size?.height ?? 15 + 20)
        
        return adjustedSize
    }
    
}

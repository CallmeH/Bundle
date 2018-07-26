//
//  AssignToEventViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout
class AssignToEventViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var prepositionDisplayLabel: UILabel!
    @IBOutlet weak var selectEventsCollectionView: UICollectionView!
    
    var todoAtAssign: Todo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectEventsCollectionView.delegate = self
        selectEventsCollectionView.dataSource = self
        
//        let cellNib = UINib(nibName: "EventTagsCollectionViewCell", bundle: nil)
//        self.collectionView.registerNib(cellNib, forCellWithReuseIdentifier: "tagCell")
//        self.collectionView.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
        self.prepositionDisplayLabel.text = prepositionStatus.displayName
        prepositionChoice.selectedSegmentIndex = Int(prepositionStatus.rawValue)
//        let alignedFlowLayout = selectEventsCollectionView?.collectionViewLayout as? AlignedCollectionViewFlowLayout
//        alignedFlowLayout?.horizontalAlignment = .left
//        alignedFlowLayout?.verticalAlignment = .top
//        self.collectionVie
        print(todoAtAssign?.title)
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
        return EventPlaceholder.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! EventTagsCollectionViewCell
        let event = EventPlaceholder[indexPath.item]
        cell.eventTag.text = event
//        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 50)
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

}

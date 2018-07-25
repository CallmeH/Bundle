//
//  AssignToEventViewController.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout
class AssignToEventViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var prepositionDisplayLabel: UILabel!
    
    @IBOutlet weak var selectEventsCollectionView: UICollectionView!
    
    
    var prepositionStatus: String? = nil
    var todoAtAssign: Todo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectEventsCollectionView.delegate = self
        selectEventsCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        self.prepositionDisplayLabel.text = prepositionStatus
        
        let alignedFlowLayout = selectEventsCollectionView?.collectionViewLayout as? AlignedCollectionViewFlowLayout
        alignedFlowLayout?.horizontalAlignment = .left
        alignedFlowLayout?.verticalAlignment = .top
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventPlaceholder.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! TagCollectionViewCell
        let event = EventPlaceholder[indexPath.item]
        cell.eventTag.text = event
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
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

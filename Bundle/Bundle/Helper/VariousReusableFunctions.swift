//
//  VariousReusableFunctions.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/25.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import Foundation
import UIKit
import AlignedCollectionViewFlowLayout

func presetCollectionViewLayout(in collectionView: UICollectionView) {
    let alignedFlowLayout = collectionView.collectionViewLayout as? AlignedCollectionViewFlowLayout
    alignedFlowLayout?.horizontalAlignment = .left
    alignedFlowLayout?.verticalAlignment = .top
    alignedFlowLayout?.minimumInteritemSpacing = 10
    alignedFlowLayout?.minimumLineSpacing = 10
}

func tagToString(_ timeTag: DefaultTag) -> String? {
    let p: prepType
    if timeTag.preposition == prepType.before.rawValue {
        p = prepType.before
    } else if timeTag.preposition == prepType.after.rawValue {
        p = prepType.after
    } else {
        p = prepType.when
    }
    return p.displayName
}

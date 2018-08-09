//
//  Constants.swift
//  Bundle
//
//  Created by Pei Qin on 2018/8/1.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import Foundation

typealias preposition = Int16
struct Constant {
    struct Segue {
        
    }
    
    struct ReviewBundleSortingOptions {
        static let time = 0
        static let event = 1
    }
    
    enum prepType: Int16 {
        case before = 0
        case when = 1
        case after = 2
        var displayName: String {
            if rawValue == 0 {
                return "Before"
            } else if rawValue == 1 {
                return "When"
            } else if rawValue == 2 {
                return "After"
            } else {
                return "Swipe to set up trigger time"
            }
        }
    }

    struct prepositionPlaceholder {
        static let before = 0
        static let when = 1
        static let after = 2
    }
    
}

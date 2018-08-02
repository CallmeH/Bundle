//
//  Constants.swift
//  Bundle
//
//  Created by Pei Qin on 2018/8/1.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation

struct Constant {
    struct Segue {
        
    }
    
    struct ReviewBundleSortingOptions {
        static let time = 0
        static let event = 1
    }
    
    let EventPlaceholder: [String] = ["get up", "leave home in the morning", "go on lunch break", "math", "english", "bathroom break", "go home", "get dinner"]
    
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



//user default
//1: set things to Codable
//let data = try? JSONEncoder.encode(<#T##JSONEncoder#>)


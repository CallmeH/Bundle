//
//  CoreDataHelper.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import CoreData

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

//write: Event.
//read: prepType(rawValue: Event.preposition or 0?)

let EventPlaceholder: [String] = ["get up", "leave home in the morning", "go on lunch break", "math", "english", "bathroom break", "go home", "get dinner"]


struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        
        let persistentContaineryay = appDelegate.persistentContainer
        let context = persistentContaineryay.viewContext
        
        return context
    }()
    
    static func newTodo() -> Todo {
        let todo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context) as! Todo
        
        return todo
    }
    
    static func save() {
        do {
            try context.save()
        } catch let error {
            print("Couldn't save \(error.localizedDescription)")
        }
    }
    
//    static func deleteTodo(todo: Todo) {
//        context.delete(todo)
//
//        save()
//    }
    
    static func retrieveTodo() -> [Todo] {
        do {
            let gofetch = NSFetchRequest<Todo>(entityName: "Todo")
            let results = try context.fetch(gofetch)
            return results
        } catch let error {
            print("Couldn't fetch \(error.localizedDescription)")
            return []
        }
    }
    
    static func retrieveEvent() -> [Event] {
        do {
            let gofetch = NSFetchRequest<Event>(entityName: "Event")
            let results = try context.fetch(gofetch)
            return results
        } catch let error {
            print("Couldn't fetch \(error.localizedDescription)")
            return []
        }
    }
    
    static func retrieveBundle() -> [Bundle] {
        do {
            let gofetch = NSFetchRequest<Bundle>(entityName: "Bundle")
            let results = try context.fetch(gofetch)
            return results
        } catch let error {
            print("Couldn't fetch \(error.localizedDescription)")
            return []
        }
    }
    
    //retrieve an unsaved session from before
}




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
    case after = 1
    case when = 2
    var displayName: String {
        switch rawValue {
        case 0:
            return "Before"
        case 1:
            return "After"
        case 2:
            return "When"
        default:
            return "not accepteed prepType"
            
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




//
//  CoreDataHelper.swift
//  Bundle
//
//  Created by Pei Qin on 2018/7/23.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import Foundation
import UIKit
import CoreData


//write: Event.
//read: prepType(rawValue: Event.preposition or 0?)

enum prepType: Int16 {
    case before = 0
    case when = 1
    case after = 2
    var displayName: String {
        if rawValue == 0 {
            return "before"
        } else if rawValue == 1 {
            return "when"
        } else if rawValue == 2 {
            return "after"
        } else {
            return "Tap to set up tag"
        }
    }
}

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
    
    static func newEvent() -> Event {
        let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as! Event

        return event
    }
    
    static func setBasicDefaultTags(newEvent: Event) -> Event {
        for i in retrieveAllDefaultTags() {
            newEvent.addToContainDefaultTag(i)
        }
        return newEvent
    }
    
    static func newBundle() -> Bundle {
        let bundle = NSEntityDescription.insertNewObject(forEntityName: "Bundle", into: context) as! Bundle
        return bundle
    }
    
    // allow the users to create their own default tags in future updates, set another entity (customTag) for one-time use tags
    static func newDefaultTag() -> DefaultTag {
        let defaultTag = NSEntityDescription.insertNewObject(forEntityName: "DefaultTag", into: context) as! DefaultTag

        return defaultTag
    }
    
    static func save() {
        do {
            try context.save()
        } catch let error {
            print("Couldn't save \(error.localizedDescription)")
        }
    }
    
    static func deleteTodo(todo: Todo) {
        context.delete(todo)

        save()
    }
    
    static func deleteEvent(event: Event) {
        context.delete(event)
        
        save()
    }
    
    static func deleteBundle(bundle: Bundle) {
        context.delete(bundle)
        
        save()
    }
    // in future updates
//    static func deleteTimeTag(timeTag: Event) {
//        context.delete(timeTag)
//
//        save()
//    }
    
    static func retrieveAllTodo() -> [Todo] {
        do {
            let gofetch = NSFetchRequest<Todo>(entityName: "Todo")
            let results = try context.fetch(gofetch)
            return results
        } catch let error {
            print("Couldn't fetch all todos \(error.localizedDescription)")
            return []
        }
    }
    
    static func retrieveUncompletedTodo() -> [Todo] {
        do {
            let fetch = NSFetchRequest<Todo>(entityName: "Todo")
            fetch.predicate = NSPredicate(format: "isCompleted == FALSE")
            let results = try context.fetch(fetch)
            return results
        } catch let error {
            print("Couldn't fetch uncompleted todo \(error.localizedDescription)")
            return []
        }
    }
    
    static func retrieveAllEvent() -> [Event] {
        do {
            let gofetch = NSFetchRequest<Event>(entityName: "Event")
            let results = try context.fetch(gofetch)
            return results
        } catch let error {
            print("Couldn't fetch all events \(error.localizedDescription)")
            return []
        }
    }
    
    static func retrieveAllDefaultTags() -> [DefaultTag] {
        do {
            let gofetch = NSFetchRequest<DefaultTag>(entityName: "DefaultTag")
            let results = try context.fetch(gofetch)
            return results
        } catch let error {
            print("Couldn't fetch all events \(error.localizedDescription)")
            return []
        }
    }
    
    static func retrieveAllBundle() -> [Bundle] {
        do {
            let gofetch = NSFetchRequest<Bundle>(entityName: "Bundle")
            let results = try context.fetch(gofetch)
            return results
        } catch let error {
            print("Couldn't fetch \(error.localizedDescription)")
            return []
        }
    }
    // in future updates
//    static func retrieveTimeTagInEvent(event: Event) -> [DefaultTag] {
//        do {
//            let fetch = NSFetchRequest<DefaultTag>(entityName: "TimeTag")
//            fetch.predicate = NSPredicate(format: "withinEvent == event")
//            let results =  try context.fetch(fetch)
//            return results
//        } catch let error {
//            print("Couldn't fetch time tags in event \(error.localizedDescription)")
//            return []
//        }
//    }
}

//
//  CoreDataManager.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 24/05/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ItemsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    // List items
    /// Fetch core data
    func getListItems() -> [PostEntity] {
        
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteItem(item: PostEntity) {
        container.viewContext.delete(item)
        
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updateItem() {
        
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print("Failed to update Item \(error)")
        }
    }
    
    func saveItem(title: String, price: Double, date: Date, id: UUID) {
        
        let item = PostEntity(context: container.viewContext)
        item.name = title
        item.price = price
        item.date = date
        item.id = id
        
        do {
            try container.viewContext.save()
        } catch {
            print("Failed to save Item \(error)")
        }
    }
    
    
    
    // Goals
    /// fetch goals
    func getGoals() -> [PiggyEntity] {
        let fetchGoalsRequest: NSFetchRequest<PiggyEntity> = PiggyEntity.fetchRequest()
        
        do {
            return try container.viewContext.fetch(fetchGoalsRequest)
        } catch {
            return []
        }
    }
    
    func deleteGoal(item: PiggyEntity) {
        container.viewContext.delete(item)
        
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updateGoal() {
        
        do {
            try container.viewContext.save()
        } catch {
            container.viewContext.rollback()
            print("Failed to update Goal \(error)")
        }
    }
    
    func saveGoal(goal: Double, name: String, emoji: String) {
        
        let piggy = PiggyEntity(context: container.viewContext)
        piggy.goal = goal
        piggy.emoji = emoji
        piggy.name = name
        
        do {
            try container.viewContext.save()
        } catch {
            print("Failed to save Goal \(error)")
        }
    }

}

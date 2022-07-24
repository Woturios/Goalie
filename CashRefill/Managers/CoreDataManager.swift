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
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "ItemsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    // List items
    /// Fetch core data
    func getListItems() -> [PostEntity] {
        
        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteItem(item: PostEntity) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            context.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updateItem() {
        
        do {
            try context.save()
        } catch {
            context.rollback()
            print("Failed to update Item \(error)")
        }
    }
    
    func saveItem(title: String, price: Double, date: Date, id: UUID, piggyID: UUID) {
        
        let item = PostEntity(context: context)
        item.name = title
        item.price = price
        item.date = date
        item.id = id
        item.piggyID = piggyID
        
        do {
            try context.save()
        } catch {
            print("Failed to save Item \(error)")
        }
    }
    
    
    
    // Goals
    /// fetch goals
    func getGoals() -> [PiggyEntity] {
        let fetchGoalsRequest: NSFetchRequest<PiggyEntity> = PiggyEntity.fetchRequest()
        
        do {
            return try context.fetch(fetchGoalsRequest)
        } catch {
            return []
        }
    }
    
    func deleteGoal(item: PiggyEntity) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            context.rollback()
            print("Failed to save context \(error)")
        }
    }
    
    func updateGoal() {
        
        do {
            try context.save()
        } catch {
            context.rollback()
            print("Failed to update Goal \(error)")
        }
    }
    
    func saveGoal(goal: Double, name: String, emoji: String, id: UUID) {
        
        let piggy = PiggyEntity(context: context)
        piggy.goal = goal
        piggy.emoji = emoji
        piggy.name = name
        piggy.id = id
        
        do {
            try context.save()
        } catch {
            print("Failed to save Goal \(error)")
        }
    }

}

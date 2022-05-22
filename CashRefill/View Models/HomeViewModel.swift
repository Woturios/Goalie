//
//  HomeViewModel.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import Foundation
import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [PostEntity] = []
    
    @Published var changeTheme: Bool = false
    
    @Published var textFieldName: String = ""
    @Published var textFieldPrice: Double = 0
    @Published var portfolioSummary: Double = 0
    
    init() {
        container = NSPersistentContainer(name: "ItemsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        fetchCoreItems()
        updatePortfolio()
    }

    func fetchCoreItems() {
        let request = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func updatePortfolio() {
        portfolioSummary = savedEntities.sum(\.price)
    }
    
    func addPost(text: String, price: Double) {
        let newPost = PostEntity(context: container.viewContext)
        newPost.name = text
        newPost.price = price
        saveData()
    }
    
    func deletePost(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    /*
//    func updatePost(entity: PostEntity) {
//        let currentName = entity.name ?? ""
//        let currentPrice = entity.price
//        let newName = currentName + "!"
//        let newPrice = currentPrice + 10
//        entity.name = newName
//        entity.price = newPrice
//        saveData()
//    }
     */
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchCoreItems()
            portfolioSummary = savedEntities.sum(\.price)
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
}

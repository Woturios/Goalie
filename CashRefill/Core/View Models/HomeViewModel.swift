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
    
    let coreDataManager: CoreDataManager = CoreDataManager()
    @Published var savedEntities: [PostEntity] = [PostEntity]()
        
    @Published var textFieldName: String = ""
    @Published var textFieldPrice: String = ""
    
    @Published var portfolioSummary: Double = 0
    @AppStorage("goal") var goal: String = ""
    @Published var goalPercentage: Double = 0
    
    @Published var selectedTab: Int = 0
    @Published var showSheet: Bool = false
//    @Published var editingSheet: Bool = false
    @Published var alertIsToggled: Bool = false

    
    init() {
//        container = NSPersistentContainer(name: "ItemsContainer")
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                print("ERROR LOADING CORE DATA. \(error)")
//            }
//        }
        reloadItems()
        updateBilance()
    }

    // Fetch items
    func fetchPortfolio() -> [PostEntity] {
        coreDataManager.getListItems()
    }
    
    // Reload items
    func reloadItems() {
        savedEntities = fetchPortfolio()
    }
    
    // Delete item
    func deletePost(indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = savedEntities[index]
            coreDataManager.deleteItem(item: item)
            reloadItems()
        }
//        guard let index = indexSet.first else { return }
//        let entity = savedEntities[index]
//        container.viewContext.delete(entity)
//        saveData()
        updateBilance()
    }
    
    // Update item
    func updatePost() {
        coreDataManager.updateItem()
    }
    
    // Save item
    func saveData(price: String) {
        coreDataManager.saveItem(title: textFieldName, price: Double(price) ?? 0)
//        do {
//            try container.viewContext.save()
//            fetchPortfolio()
//            portfolioSummary = savedEntities.sum(\.price)
//        } catch let error {
//            print("Error saving. \(error)")
//        }
    }
    
    
    // Update list item
//    func updatePostItem() {
//
//    }
    
    // update Account Bilance and percentage
    func updateBilance() {
        portfolioSummary = savedEntities.sum(\.price)
        goalPercentage = Double((portfolioSummary / (Double(goal) ?? 0) * 100))
    }
    
    // update goal percentage
    func updateGoalPercentage() {
        goalPercentage = Double((portfolioSummary / (Double(goal) ?? 0) * 100))
    }
    
    
    
    func addNewItemToList() {
        let fieldPrice = String(textFieldPrice.replacingOccurrences(of: ",", with: "."))
        saveData(price: fieldPrice)
        UIApplication.shared.endEdditing()
        textFieldName = ""
        textFieldPrice = ""
        reloadItems()
        portfolioSummary = savedEntities.sum(\.price)
    }
    
    func getBackgroundColor() -> Color {
        if selectedTab == 0 {
            return Color.blue
        } else if selectedTab == 1 {
            return Color.red
        } else {
            return Color.green
        }
    }
    
}

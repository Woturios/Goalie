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
    
    // MARK: PROPERTIES
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

    
    // MARK: INIT
    init() {
        reloadItems()
        updateBilance()
    }

    // MARK: FUNC
    // Fetch items
    func fetchPortfolio() -> [PostEntity] {
        coreDataManager.getListItems()
    }
    
    // New items on top
    func sortedListItems() -> [PostEntity] {
        savedEntities.reversed()
    }
    
    // Reload items
    func reloadItems() {
        savedEntities = fetchPortfolio()
    }
    
    // Delete item
    func deletePost(indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = sortedListItems()[index]
            coreDataManager.deleteItem(item: item)
            reloadItems()
        }
        updateBilance()
    }
    
    // Update item
    func updatePost() {
        coreDataManager.updateItem()
    }
    
    // Save item
    func saveData(price: String) {
        coreDataManager.saveItem(title: textFieldName, price: Double(price) ?? 0)
    }
    
    
    func updateBilance() {
        portfolioSummary = sortedListItems().sum(\.price)
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
    
    
    // MARK: THEME FUNC
    func getAccentColor() -> Color {
        if selectedTab == 0 {
            return Color.blue
        } else if selectedTab == 1 {
            return Color.red
        } else {
            return Color.green
        }
    }
    
}

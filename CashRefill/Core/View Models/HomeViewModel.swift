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
    @Published var savedEntities: [PostEntity] = []
    @Published var sortedArray: [PostEntity] = []
        
    @Published var textFieldName: String = ""
    @Published var textFieldPrice: String = ""
    
    @Published var portfolioSummary: Double = 0
    @AppStorage("goal") var goal: Double = 0
    @Published var goalPercentage: Double = 0
    
    @Published var selectedTab: Int = 0
    @Published var showSheet: Bool = false
    @Published var alertIsToggled: Bool = false
    
    @AppStorage("SelectedTheme") var selectedTheme: Int = 1
    
    // MARK: INIT
    init() {
        reloadItems()
        sortListItems()
        updateBilance()
    }

    // MARK: FUNC
    // Fetch items
    func fetchPortfolio() -> [PostEntity] {
        coreDataManager.getListItems()
    }
    
    // New items on top
    func sortListItems() {
        sortedArray = savedEntities.sorted(by: {$0.date ?? Date() > $1.date ?? Date()})
    }
    
    // Reload items
    func reloadItems() {
        savedEntities = fetchPortfolio()
        sortListItems()
    }
    
    // Delete item
    func deletePost(indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = sortedArray[index]
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
    func saveData(price: String, date: Date) {
        coreDataManager.saveItem(title: textFieldName, price: Double(price) ?? 0, date: date)
    }
    
    
    func updateBilance() {
        portfolioSummary = savedEntities.sum(\.price)
        updateGoalPercentage()
    }
    
    // update goal percentage
    func updateGoalPercentage() {
        goalPercentage = (portfolioSummary / goal * 100)
    }
    
    func goalAsCurrency() -> String {
        return goal.asCurrencyWith0Decimals()
    }
    
    func addNewItemToList() {
        let fieldPrice = String(textFieldPrice.replacingOccurrences(of: ",", with: "."))
        let currentDate = Date()
        saveData(price: fieldPrice, date: currentDate)
        UIApplication.shared.endEdditing()
        textFieldName = ""
        textFieldPrice = ""
        reloadItems()
        updateBilance()
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

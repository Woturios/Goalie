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
    @Published var mappedArray: [Month] = []
    @Published var filteredArray: [PostEntity] = []
    @Published var mappedFilteredArray: [FilteredMonth] = []
    
    @Published var goalsArray: [PiggyEntity] = []
        
    @Published var textFieldName: String = ""
    @Published var textFieldPrice: String = ""
    @Published var goalID: UUID?
    @AppStorage("selectGoal") var selectedGoal: String?
    @Published var currentEmoji: String = "🤨"
    
    @Published var fieldGoalPrice: Double = 0
    @Published var fieldGoalName: String = ""
    
    @Published var portfolioSummary: Double = 0
    @AppStorage("goal") var goal: Double = 0
    @Published var goalPercentage: Double = 0
    
    @Published var isPresented: Bool = false
    @Published var selectedTab: Int = 0
    @Published var showSheet: Bool = false
    @Published var alertIsToggled: Bool = false
    @AppStorage("dataDisplayStyle") var dataDisplayStyle: Bool = true
    
    @AppStorage("SelectedTheme") var selectedTheme: Int = 1
    @AppStorage("preferedColorMode") var preferedColorMode: Int = 2
    
    // MARK: INIT
    init() {
        reloadItems()
        reloadGoals()
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
    
    func mapListItems() {
        let grouped = Dictionary(grouping: sortedArray) { (entity: PostEntity) -> String in
            DateFormatter.displayDate.string(from: entity.date ?? Date())
        }
        
        self.mappedArray = grouped.map({ month -> Month in
            Month(title: month.key, items: month.value, price: month.value[0].price, date: month.value[0].date ?? Date())
        }).sorted(by: { $0.date > $1.date })
    }
    
    func filterArray(goal: PiggyEntity) {
        filteredArray = sortedArray.filter({ $0.piggyID == goal.id })
    }
    
    func mapFilteredItems(goal: PiggyEntity) {
        let groupedFiltered = Dictionary(grouping: sortedArray) { (entity: PostEntity) -> String in
            DateFormatter.displayDate.string(from: entity.date ?? Date())
        }
        
        self.mappedFilteredArray = groupedFiltered.map({ month -> FilteredMonth in
            FilteredMonth(piggyID: month.value[0].piggyID ?? UUID(), title: month.key, items: month.value, price: month.value[0].price, date: month.value[0].date ?? Date())
        }).sorted(by: { $0.date > $1.date }).filter({$0.piggyID == goal.id})
    }
    
    // Reload items
    func reloadItems() {
        savedEntities = fetchPortfolio()
        sortListItems()
        mapListItems()
    }
    
    // Delete item
    func deletePost(indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = sortedArray[index]
            coreDataManager.deleteItem(item: item)
            reloadItems()
        }
    }
    
    func deleteFiltered(indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = filteredArray[index]
            coreDataManager.deleteItem(item: item)
            reloadItems()

        }
    }
    
    
    // Update item
    func updatePost() {
        coreDataManager.updateItem()
    }
    
    // Save item
    func saveData(price: String, date: Date, id: UUID, piggyId: UUID) {
        coreDataManager.saveItem(title: textFieldName, price: Double(price) ?? 0, date: date, id: id, piggyID: piggyId)
    }
    
    func updateBilance(goal: Double) {
        portfolioSummary = sortedArray.sum(\.price)
        updateGoalPercentage(goal: goal)
    }
    
    // update goal percentage
    func updateGoalPercentage(goal: Double) {
        goalPercentage = (portfolioSummary / goal)
    }
    
    func goalAsCurrency() -> String {
        return goal.asCurrencyWith0Decimals()
    }
    
    func addNewItemToList() {
        let fieldPrice = String(textFieldPrice.replacingOccurrences(of: ",", with: "."))
        let currentDate = Date()
        if let firstGoal = goalsArray.first(where: { $0.name == selectedGoal }) {
            goalID = firstGoal.id
        }
        guard let goalId = goalID else { return }
        saveData(price: fieldPrice, date: currentDate, id: UUID(), piggyId: goalId)
        UIApplication.shared.endEdditing()
        textFieldName = ""
        textFieldPrice = ""
        reloadItems()
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
    
    func toggleDataDisplayStyle() {
        dataDisplayStyle.toggle()
    }
    
    // MARK: GOALS
    func fetchGoals() -> [PiggyEntity] {
        coreDataManager.getGoals()
    }
    
    func saveGoal(goal: Double, name: String, emoji: String, id: UUID) {
        coreDataManager.saveGoal(goal: goal, name: name, emoji: emoji, id: id)
    }
    
    func reloadGoals() {
        goalsArray = fetchGoals()
    }
    
    func deleteGoal(item: PiggyEntity) {
        coreDataManager.deleteGoal(item: item)
        reloadGoals()
    }
    
    func updateGoal() {
        coreDataManager.updateGoal()
    }
    
    func addNewGoal(goal: Double, name: String) {
        saveGoal(goal: goal, name: name, emoji: currentEmoji, id: UUID())
        UIApplication.shared.endEdditing()
        fieldGoalName = ""
        fieldGoalPrice = 0
        reloadGoals()
    }

}

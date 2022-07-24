//
//  GoalDetailView.swift
//  CashRefill
//
//  Created by Woturios on 24/07/2022.
//

import SwiftUI

struct GoalDetailView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    let goal: PiggyEntity
    
    
    var body: some View {
        VStack {
            SingleGoalView(emoji: goal.emoji ?? "🤨", goalTitle: goal.name ?? "no name", currentProgress: vm.portfolioSummary, progressPercentage: vm.goalPercentage, goalSet: goal.goal, barProgress: $vm.goalPercentage)
            
            List {
                ForEach(vm.filteredArray) { item in
                    HStack {
                        Text(item.name ?? "no name")
                        Spacer()
                        Text("\(item.price.asCurrencyWith2Decimals())")
                        
                    }
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            vm.filterArray(goal: goal)
            vm.updateBilance(goal: goal.goal)
        }
    }
}

//struct GoalDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalDetailView(goal: )
//            .environmentObject(HomeViewModel())
//    }
//}

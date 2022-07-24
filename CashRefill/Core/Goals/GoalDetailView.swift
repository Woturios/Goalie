//
//  GoalDetailView.swift
//  CashRefill
//
//  Created by Woturios on 24/07/2022.
//

import SwiftUI

struct GoalDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    let goal: PiggyEntity
    
    
    var body: some View {
        VStack {
            NavigationBackView()
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            
            SingleGoalView(emoji: goal.emoji ?? "🤨", goalTitle: goal.name ?? "no name", currentProgress: vm.portfolioSummary, progressPercentage: vm.goalPercentage, goalSet: goal.goal, barProgress: $vm.goalPercentage)
            
            Button {
                vm.deleteGoal(item: goal)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("DELETE")
                    .withDefaultButtonFormatting(backgroundColor: Color.red, foregroundColor: Color.theme.accent)
                    .withPressableStyle()
            }

            
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
                .onDelete(perform: vm.deleteFiltered)
            }
            .listStyle(.plain)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal)
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

//
//  GoalEditingView.swift
//  CashRefill
//
//  Created by Woturios on 29/07/2022.
//

import SwiftUI

struct GoalEditingView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    let piggy: PiggyEntity
    @State var goalName: String
    @State var goalPrice: String
    
    var body: some View {
        VStack {
            Text("Edit your goal")
                .font(.title)
            TextField(piggy.name ?? "Edit name", text: $goalName)
                .withDefaultTextFieldFormatting()
            
            TextField("\(piggy.goal.asCurrencyWith2Decimals())", text: $goalPrice)
                .withDefaultTextFieldFormatting()
            
            Button {
                piggy.name = goalName
                piggy.goal = Double(goalPrice) ?? 0
                vm.updateGoal()
                vm.reloadGoals()
            } label: {
                Text("SAVE")
            }
            .withDefaultButtonFormatting()
            .withPressableStyle()

        }
        .padding(.horizontal)
        .onAppear {
            piggy.name = goalName
            piggy.goal = Double(goalPrice) ?? 0
        }
    }
}

//struct GoalEditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalEditingView()
//            .environmentObject(HomeViewModel())
//    }
//}

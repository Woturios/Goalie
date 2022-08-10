//
//  GoalsView.swift
//  CashRefill
//
//  Created by Woturios on 14/07/2022.
//

import SwiftUI

struct GoalsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        ZStack {
            GetBackgroundTheme()
            
            ScrollView {
                VStack {
                    navigation
        
                    ForEach(vm.goalsArray) { goal in
                        NavigationLink {
                            GoalDetailView(goal: self.$vm.goalsArray[self.vm.goalsArray.firstIndex(of: goal)!])
                        } label: {
                            SingleGoalView(emoji: goal.emoji ?? "", goalTitle: goal.name ?? "NO name", currentProgress: 0, progressPercentage: Double(0 / goal.goal), goalSet: goal.goal, barProgress: $vm.goalPercentage)
                        }
                        .foregroundColor(Color.theme.accent)
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
            .environmentObject(HomeViewModel())
    }
}

extension GoalsView {
    private var navigation: some View {
        HStack(spacing: 20) {
            Text("Your Goals")
                .font(.title2)
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
            
            Spacer()
            NavigationLink {
                NewGoalView()
            } label: {
                CircleButton(buttonName: "crown")
            }
        }
//        .padding(.top, 25)
    }
}

struct SingleGoalView: View {
    
    let emoji: String
    let goalTitle: String
    let currentProgress: Double
    let progressPercentage: Double
    let goalSet: Double
    @Binding var barProgress: Double
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(emoji)
                    Text(goalTitle)
                        .fontWeight(.bold)
                }
                .font(.largeTitle)
                
                HStack {
                    Text("\(currentProgress.asCurrencyWith0Decimals())")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(progressPercentage.asPercentage())")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(goalSet.asCurrencyWith0Decimals())")
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 3)
                .font(.title)
                
                ProgressBar(value: $barProgress)
                    .frame(height: 20)
            }
            .padding(.horizontal)
            .minimumScaleFactor(0.1)
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
    }
}

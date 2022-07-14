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
            
            VStack {
                navigation
                SingleGoalView(emoji: "📱", goalTitle: "iPhone", currentProgress: 100, progressPercentage: 10, goalSet: 5100)
                Spacer()
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
            CircleButton(buttonName: "crown")
                .onTapGesture {
                    vm.showSheet = true
                }
                .sheet(isPresented: $vm.showSheet) {
                    GoalView()
                }
        }
        .padding(.horizontal)
        .padding(.top, 25)
    }
}

struct SingleGoalView: View {
    
    let emoji: String
    let goalTitle: String
    let currentProgress: Double
    let progressPercentage: Double
    let goalSet: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.thinMaterial)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(emoji)
                    Text(goalTitle)
                        .fontWeight(.bold)
                }
                .font(.largeTitle)
                
                HStack {
                    Text("\(currentProgress)")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(progressPercentage)" + "%")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(goalSet)")
                        .fontWeight(.semibold)
                }
                .font(.title)
                
                ProgressBar(value: .constant(0.7))
                    .frame(height: 20)
            }
            .padding()
            .minimumScaleFactor(0.1)
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .padding()

    }
}

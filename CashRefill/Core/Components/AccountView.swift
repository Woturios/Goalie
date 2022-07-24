//
//  AccountView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    // MARK: BODY
    var body: some View {
        TabView(selection: $vm.selectedTab) {
            balanceTile
                .tag(0)
            goalTile
                .tag(1)
            percentageTile
                .tag(2)
        }
        .frame(height: 100)
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

// MARK: PREVIEWS
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .padding(.vertical)
            .environmentObject(HomeViewModel())
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
        
        AccountView()
            .padding(.vertical)
            .environmentObject(HomeViewModel())
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

// MARK: EXTENSION
extension AccountView {
    
    
    // MARK: account
    private var percentageTile: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.theme.thirdTabBg)
                .padding(.horizontal)
            
            HStack(spacing: 20) {
//                 PROGRESSIVE EMOTICON SHOWING PROGRESS IN %
                if vm.goal != 0 {
                    VStack(spacing: 1) {
                        ForEach(1..<11) { index in
                            Rectangle()
                                .frame(width: 55, height: 5)
                                .foregroundColor(Double(11 - index) > (Double(vm.goalPercentage / 10) + 0.05) ? Color.theme.thirdTabContent.opacity(0.1) : Color.theme.thirdTabContent)
                        }
                    }
                } else {
                    Text("😱")
                        .font(.system(size: 55))
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("Progress")
                            .font(.headline)
                            .foregroundColor(Color.theme.thirdTabContent)
                    }
                    if vm.goal != 0 {
                        Text("\(vm.goalPercentage.asPercentage())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.thirdTabContent)
                    } else {
                        Text("Add your goal!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.thirdTabContent)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
            .minimumScaleFactor(0.5)
        }
    }
    
    // MARK: balance
    private var balanceTile: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.theme.firstTabBg)
                .padding(.horizontal)
            HStack(spacing: 20) {
                Text("💸")
                    .font(.system(size: 55))
                VStack(alignment: .leading) {
                    HStack {
                        Text("Savings")
                            .font(.headline)
                            .foregroundColor(Color.theme.firstTabContent)
                    }
                    Text("\(vm.portfolioSummary.asCurrencyWith2Decimals())")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.firstTabContent)
                }
            }
        }
    }
    
    // MARK: goal
    private var goalTile: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.theme.secondTabBg)
                .padding(.horizontal)
            HStack(spacing: 20) {
                Text("🏆")
                    .font(.system(size: 55))
                VStack(alignment: .leading) {
                    HStack {
                        Text("Goal")
                            .font(.headline)
                            .foregroundColor(Color.theme.secondTabContent)
                    }
                    if vm.goal != 0 {
                        Text("\(vm.goal.asCurrencyWith0Decimals())")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.secondTabContent)
                    } else {
                        Text("Add your goal!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.secondTabContent)
                            .minimumScaleFactor(0.5)
                    }
                    
                }
            }
        }
    }
}

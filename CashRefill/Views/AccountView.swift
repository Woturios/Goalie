//
//  AccountView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        TabView(selection: $vm.selectedTab) {
            AccountSummaryView(portfolioSummary: vm.portfolioSummary, emoticonString: "💸", summaryTitle: "Balance", backgroundColor: Color.theme.firstTabBg, contentColor: Color.theme.firstTabContent, specifier: "%.2f")
                .tag(0)
            AccountSummaryView(portfolioSummary: Double(vm.goal) ?? 0, emoticonString: "🏆", summaryTitle: "Goal", backgroundColor: Color.theme.secondTabBg, contentColor: Color.theme.secondTabContent, specifier: "%.0f")
                .tag(1)
            percentageTile
            .tag(2)
        }
        .frame(height: 150)
        .tabViewStyle(.page)
    }
}

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

struct AccountSummaryView: View {
    
    var portfolioSummary: Double
    var emoticonString: String
    var summaryTitle: String
    var backgroundColor: Color
    let contentColor: Color
    var specifier: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .foregroundColor(backgroundColor)
                .padding(.horizontal)
            HStack(spacing: 20) {
                Text(emoticonString)
                    .font(.system(size: 55))
                VStack(alignment: .leading) {
                    HStack {
                        Text(summaryTitle)
                            .font(.headline)
                            .foregroundColor(contentColor)
                    }
                    Text("\(portfolioSummary, specifier: specifier) zł")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(contentColor)
                }
            }
        }
    }
}

extension AccountView {
    private var percentageTile: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.theme.thirdTabBg)
                .padding(.horizontal)
            HStack(spacing: 20) {
                // NORMAL EMOTICON
//                Text("😱")
//                    .font(.system(size: 55))
                
                // PROGRESSIVE EMOTICON SHOWING PROGRESS IN %
                VStack(spacing: 1) {
                    ForEach(1..<11) { index in
                        Rectangle()
                            .frame(width: 55, height: 5)
                            .foregroundColor(Double(11 - index) > Double(vm.goalPercentage / 10) ? Color.theme.thirdTabContent.opacity(0.1) : Color.theme.thirdTabContent)
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("Progress")
                            .font(.headline)
                            .foregroundColor(Color.theme.thirdTabContent)
                    }
                    Text("\(vm.goalPercentage, specifier: "%.0f") %")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.thirdTabContent)
                }
            }
        }
    }
}

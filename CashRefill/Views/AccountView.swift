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
            balanceTile
                .tag(0)
            goalTile
                .tag(1)
                .onTapGesture {
                    vm.showSheet = true
                }
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

/*
//struct AccountSummaryView: View {
//
//    var portfolioSummary: Double
//    var emoticonString: String
//    var summaryTitle: String
//    var backgroundColor: Color
//    let contentColor: Color
//    var specifier: String
//
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 25)
//                .frame(height: 150)
//                .frame(maxWidth: .infinity)
//                .foregroundColor(backgroundColor)
//                .padding(.horizontal)
//            HStack(spacing: 20) {
//                Text(emoticonString)
//                    .font(.system(size: 55))
//                VStack(alignment: .leading) {
//                    HStack {
//                        Text(summaryTitle)
//                            .font(.headline)
//                            .foregroundColor(contentColor)
//                    }
//                    Text("\(portfolioSummary, specifier: specifier) zł")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(contentColor)
//                }
//            }
//        }
//    }
//}
 */

extension AccountView {
    private var percentageTile: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.theme.thirdTabBg)
                .padding(.horizontal)
            HStack(spacing: 20) {
//                 NORMAL EMOTICON
//                Text("😱")
//                    .font(.system(size: 55))
                
//                 PROGRESSIVE EMOTICON SHOWING PROGRESS IN %
                if vm.goal != "" {
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
                    if vm.goal != "" {
                        Text("\(vm.goalPercentage, specifier: "%.0f") %")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.thirdTabContent)
                    } else {
                        Text("Add your goal!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.thirdTabContent)
                    }
                }
            }
        }
    }
    
    private var balanceTile: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.theme.firstTabBg)
                .padding(.horizontal)
            HStack(spacing: 20) {
                Text("💸")
                    .font(.system(size: 55))
                VStack(alignment: .leading) {
                    HStack {
                        Text("Balance")
                            .font(.headline)
                            .foregroundColor(Color.theme.firstTabContent)
                    }
                    Text("\(vm.portfolioSummary, specifier: "%.2f") zł")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.firstTabContent)
                }
            }
        }
    }
    
    private var goalTile: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 150)
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
                    if vm.goal != "" {
                        Text("\(Double(vm.goal) ?? 0, specifier: "%.0f") zł")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.secondTabContent)
                    } else {
                        Text("Add your goal!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.secondTabContent)
                    }
                    
                }
            }
        }
    }
}

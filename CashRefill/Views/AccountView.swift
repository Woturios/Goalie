//
//  AccountView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            AccountSummaryView(portfolioSummary: vm.portfolioSummary, emoticonString: "💸", summaryTitle: "Balance", backgroundColor: Color.blue, contentColor: Color.white)
                .tag(0)
            AccountSummaryView(portfolioSummary: 5000, emoticonString: "🏆", summaryTitle: "Goal", backgroundColor: Color.orange, contentColor: Color.black)
                .tag(1)
//            AccountSummaryView(portfolioSummary: 12, emoticonString: "", summaryTitle: "Test", backgroundColor: Color.black, contentColor: Color.white)
//                .tag(2)
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
                    Text("\(portfolioSummary, specifier: "%.2f") zł")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(contentColor)
                }
            }
        }
    }
}

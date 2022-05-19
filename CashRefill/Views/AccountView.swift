//
//  AccountView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    var portfolioSummary: Double
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Saldo:")
                        .font(.headline)
                        .foregroundColor(Color.primary)
                    Spacer()
                }
                Text("\(portfolioSummary, specifier: "%.2f") PLN")
                    .font(.title)
                    .fontWeight(.bold)
            }
            NavigationLink(destination: AddView(textFieldName: vm.textFieldName, textFieldPrice: vm.textFieldPrice, portfolioSummary: vm.portfolioSummary)) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(Color("PrimaryColor"))
            }
        }
        .padding(.horizontal)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(portfolioSummary: 100)
    }
}

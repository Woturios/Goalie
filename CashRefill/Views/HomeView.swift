//
//  HomeView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 18/05/2022.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    //    @State var textFieldName: String = ""
    //    @State var textFieldPrice: Double = 0
    //    @State var portfolioSummary: Double = 0
    
    var body: some View {
        VStack(spacing: 20) {
            AccountView(portfolioSummary: vm.portfolioSummary)           
            
            List {
                ForEach(vm.savedEntities) { entity in
                    HStack {
                        Text(entity.name ?? "No Name")
                            .font(.headline)
                        Spacer()
                        Text("\(entity.price, specifier: "%.2f") PLN")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                }
                .onDelete(perform: vm.deletePost)
            }
            .listStyle(.plain)
        }
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
        
        HomeView()
            .preferredColorScheme(.light)
    }
}

extension Sequence  {
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T { reduce(.zero) { $0 + predicate($1) } }
}

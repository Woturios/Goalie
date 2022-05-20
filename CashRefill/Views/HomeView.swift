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
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            HStack {
                NavigationLink {
                    SettingsView()
                } label: {
                    CircleButton(buttonName: "gearshape.fill")
                }
                Spacer()
                NavigationLink {
                    AddView(textFieldName: vm.textFieldName, textFieldPrice: vm.textFieldPrice, portfolioSummary: vm.portfolioSummary)
                } label: {
                    Text("Add new")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.accent)
                    CircleButton(buttonName: "plus.circle.fill")
                }
            }
            .padding(.horizontal)
            
            AccountView(portfolioSummary: vm.portfolioSummary)
            ListTitleView()
            if vm.savedEntities.isEmpty {
                VStack(alignment: .center){
                    Spacer()
                    Text("There is nothing on your list. Press + to add new item. 😱😨😰")
                        .font(.headline)
                        .foregroundColor(Color.theme.secondaryText)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            } else {
                ListView()
            }
        }
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .preferredColorScheme(.light)
                .environmentObject(HomeViewModel())
        }
        
        NavigationView {
            HomeView()
                .preferredColorScheme(.dark)
                .environmentObject(HomeViewModel())
        }
    }
}

extension Sequence  {
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T { reduce(.zero) { $0 + predicate($1) } }
}


struct ListTitleView: View {
    var body: some View {
        Text("History 🕰")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.horizontal)
            .foregroundColor(Color.theme.accent)
    }
}

struct ListView: View {
    
    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Item:")
                    .font(.caption)
                    .foregroundColor(Color.primary)
                Spacer()
                Text("Price:")
                    .font(.caption)
                    .foregroundColor(Color.primary)
            }
            .padding(.horizontal)
            List {
                ForEach(vm.savedEntities) { entity in
                    HStack {
                        Text(entity.name ?? "No Name")
                            .font(.headline)
                        Spacer()
                        Text("\(entity.price, specifier: "%.2f") zł")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
                .onDelete(perform: vm.deletePost)
            }
            .listStyle(.plain)
        }
    }
}

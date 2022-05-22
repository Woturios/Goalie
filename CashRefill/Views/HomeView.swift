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
        ZStack {
            if vm.selectedTab == 0 {
                RadialGradient(colors: [Color.blue.opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            } else if vm.selectedTab == 1 {
                RadialGradient(colors: [Color.orange.opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            } else {
                RadialGradient(colors: [Color.green.opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            }
            
            VStack(alignment: .leading, spacing: nil) {
                homeNavigation
                AccountView()
                listTitleView
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
                    listView
                }
            }
            .navigationBarHidden(true)
        }
        
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




extension HomeView {
    
    private var homeNavigation: some View {
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
                    .foregroundColor(vm.accentColor)
                CircleButton(buttonName: "plus.circle.fill")
            }
        }
        .padding(.horizontal)
    }
    
    private var listTitleView: some View {
        Text("History 🕰")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.horizontal)
            .foregroundColor(vm.accentColor)
    }
    
    
    private var listView: some View {
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
                    .listRowBackground(Color.clear)
                }
                .onDelete(perform: vm.deletePost)
            }
            .listStyle(.plain)
        }
    }
}

//
//  HomeView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 18/05/2022.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    // MARK: PROPERTIES
    @EnvironmentObject private var vm: HomeViewModel
    @State var settingsSheet: Bool = false
    
    // MARK: BODY
    var body: some View {
        ZStack {
            GetBackgroundTheme()
            
            VStack(alignment: .leading, spacing: 3) {
                homeNavigation
                AccountView()
                    .sheet(isPresented: $vm.showSheet) {
                        GoalView()
                    }
                //                listTitleView
                if vm.sortedListItems().isEmpty {
                    VStack(alignment: .center){
                        Spacer()
                        Text("There is nothing on your list. Press + to add new item. 😱😨😰")
                            .font(.headline)
                            .foregroundColor(Color.secondary)
                            .multilineTextAlignment(.center)
                        Spacer()
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                } else {
//                    Text("\(Date())")
                    listView
                }
            }
            .navigationBarHidden(true)
        }
        
    }
}

// MARK: PREVIEWS
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



// MARK: EXTENSION
extension HomeView {
    
    private var homeNavigation: some View {
        HStack(spacing: 20) {
            Text("Your Savings")
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            CircleButton(buttonName: "crown")
                .onTapGesture {
                    vm.showSheet = true
                }
                .sheet(isPresented: $vm.showSheet) {
                    GoalView()
                }
            CircleButton(buttonName: "gearshape")
                .onTapGesture {
                    settingsSheet = true
                }
                .sheet(isPresented: $settingsSheet) {
                    SettingsView()
                }
            NavigationLink {
                AddView()
            } label: {
                CircleButton(buttonName: "plus.circle")
            }
        }
        .minimumScaleFactor(0.5)
        .padding(.horizontal)
        .padding(.top, 25)
    }
    
    private var listTitleView: some View {
        Text("History 🕰")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.horizontal)
            .foregroundColor(Color.theme.accent)
    }
    
    
    private var listView: some View {
        VStack {
            HStack {
                Text("Item:")
                    .font(.caption)
                    .foregroundColor(Color.theme.accent)
                Spacer()
                Text("Price:")
                    .font(.caption)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.horizontal)
            
            List {
                ForEach(vm.sortedArray) { entity in
                    ZStack {
                        HStack {
                            Text(entity.name ?? "No Name")
                                .font(.headline)
                                .foregroundColor(Color.theme.accent)
                            Spacer()
//                            Text("\(entity.date?.formatted(date: .numeric, time: .shortened) ?? "")")
//                            Spacer()
                            Text("\(entity.price.asCurrencyWith2Decimals())")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme.accent)
                        }
                        
                        NavigationLink {
                            EditingView(itemName: entity.name ?? "", itemPrice: String("\(entity.price)"), item: entity)
                        } label: {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                    .listRowBackground(Color.clear)
                }
                .onDelete(perform: vm.deletePost)
            }
            .foregroundColor(Color.theme.accent)
            .navigationBarHidden(true)
            .listStyle(.plain)
        }
    }
}



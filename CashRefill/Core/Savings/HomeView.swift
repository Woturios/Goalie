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
    @State var selectedGoal: String = ""
    
    // MARK: BODY
    var body: some View {
        ZStack {
            GetBackgroundTheme()
            
            VStack(alignment: .leading, spacing: 3) {
                homeNavigation
                AccountView()
                if vm.savedEntities.isEmpty {
                    nothingOnListView
                } else {
                    if selectedGoal == "" {
                        listView
                    } else if selectedGoal == vm.goalsArray.first(where: { $0.name == selectedGoal })?.name {
                        List {
                            ForEach(vm.filteredArray) { item in
                                HStack {
                                    Text(item.name ?? "no name")
                                    Spacer()
                                    Text("\(item.price.asCurrencyWith2Decimals())")
                                    
                                }
                                .font(.headline)
                                .foregroundColor(Color.theme.accent)
                                .listRowBackground(Color.clear)
                            }
                            .onDelete(perform: vm.deleteFiltered)
                        }
                        .listStyle(.plain)
                    }
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
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    Text("Your Savings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(selectedGoal == "" ? Color.theme.accent : Color.gray.opacity(0.5))
                        .minimumScaleFactor(0.5)
                        .onTapGesture {
                            selectedGoal = ""
                        }
                    
                    ForEach(vm.goalsArray) { goal in
                        Text(goal.name ?? "no name")
                            .foregroundColor(selectedGoal == goal.name ? Color.theme.accent : Color.gray.opacity(0.5))
                            .font(.title2)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.5)
                            .onTapGesture {
                                selectedGoal = goal.name ?? ""
                                vm.filterArray(goal: goal)
                            }
                    }
                }
            }
            
            NavigationLink {
                AddView()
            } label: {
                CircleButton(buttonName: "plus.circle")
            }
        }
        .padding(.horizontal)
        .padding(.top, 25)
    }
    
    private var nothingOnListView: some View {
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
    }
    
    
    private var listView: some View {
        VStack {
            List {
                ForEach(vm.mappedArray) { section in
                    Section {
                        ForEach(section.items) { item in
                            ZStack {
                                HStack {
                                    Text(item.name ?? "No Name")
                                        .font(.headline)
                                        .foregroundColor(Color.theme.accent)
                                    Spacer()
                                    Text("\(item.price.asCurrencyWith2Decimals())")
                                        .font(.headline)
                                        .foregroundColor(Color.theme.accent)
                                }

                                NavigationLink {
                                    EditingView(itemName: (item.name ?? item.id?.uuidString) ?? "You need to repair this Item.", itemPrice: String("\(item.price)"), item: item)
                                } label: {
                                    EmptyView()
                                }
                                .opacity(0)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .onDelete(perform: vm.deletePost)
                        
                    } header: {
                        VStack(alignment: .leading) {
                            Text("\(DateFormatter.displayDate.string(from: section.date ))")
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: vm.dataDisplayStyle ? .infinity : nil)
                                .padding(.vertical, 3)
                                .padding(.horizontal, 40)
                                .background(vm.getAccentColor().opacity(0.5))
                                .cornerRadius(10)
                            HStack {
                                Text("Item:")
                                    .font(.caption)
                                    .foregroundColor(Color.theme.accent)
                                Spacer()
                                Text("Price:")
                                    .font(.caption)
                                    .foregroundColor(Color.theme.accent)
                            }
                        }
                    }
                }
                /*
//                ForEach(vm.sortedArray) { entity in
//                    Section {
                        ZStack {
                            HStack {
                                Text(entity.name ?? "No Name")
                                    .font(.headline)
                                    .foregroundColor(Color.theme.accent)
                                Spacer()
                                Text("\(entity.price.asCurrencyWith2Decimals())")
                                    .font(.headline)
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
//
//                    } header: {
                        Text("\(DateFormatter.displayDate.string(from: entity.date ?? Date()))")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(3)
                            .background(vm.getAccentColor().opacity(0.5))
                            .cornerRadius(10)
//                    }
//                }
//                .onDelete(perform: vm.deletePost)
                 */
            }
            .foregroundColor(Color.theme.accent)
            .navigationBarHidden(true)
            .listStyle(.plain)
        }
    }
}



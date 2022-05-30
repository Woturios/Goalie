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
    @State var editingSheet: Bool = false
    
    // MARK: BODY
    var body: some View {
        ZStack {
            RadialGradient(colors: [vm.getAccentColor().opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: nil) {
//                homeNavigation
                AccountView()
                    .sheet(isPresented: $vm.showSheet) {
                        GoalView()
                    }
                listTitleView
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
                    listView
                }
            }
            .navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        AddView()
                    } label: {
                        Text("Add new")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.theme.accent)
                        CircleButton(buttonName: "plus.circle.fill")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    CircleButton(buttonName: "rosette")
                        .onTapGesture {
                            vm.showSheet = true
                        }
                }
            }
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
        HStack {
            Image(systemName: "rosette")
                .font(.title)
                .onTapGesture {
                    vm.showSheet = true
                }
            Spacer()
            NavigationLink {
                AddView()
            } label: {
                Text("Add new")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.accent)
                CircleButton(buttonName: "plus.circle.fill")
            }
        }
        .sheet(isPresented: $vm.showSheet) {
            GoalView()
        }
        .padding(.horizontal)
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
                    .foregroundColor(Color.primary)
                Spacer()
                Text("Price:")
                    .font(.caption)
                    .foregroundColor(Color.primary)
            }
            .padding(.horizontal)
            
            List {
                ForEach(vm.sortedListItems()) { entity in
                    ZStack {
                        HStack {
                            Text(entity.name ?? "No Name")
                                .font(.headline)
                            Spacer()
                            Text("\(entity.price, specifier: "%.2f") zł")
                                .font(.headline)
                                .fontWeight(.semibold)
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
            .navigationBarHidden(true)
            .listStyle(.plain)
        }
    }
}



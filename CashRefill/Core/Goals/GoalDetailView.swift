//
//  GoalDetailView.swift
//  CashRefill
//
//  Created by Woturios on 24/07/2022.
//

import SwiftUI

struct GoalDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var goal: PiggyEntity
    @State private var showEditingView: Bool = false
    @State private var showItemEditing = false
    
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                ZStack {
                    VStack {
                        Color.green
                            .frame(height: 300)

                        Spacer()
                    }
                    
                    VStack {
                        Text(goal.name ?? "no name")
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 40)
                            .padding(.top, 260)
                            .minimumScaleFactor(0.1)
                        goalStatistics
                        mappedList
                    }
                    .padding(.horizontal)

                }
            }
            .ignoresSafeArea(edges: .top)
            
            navigationBar
                .padding(.horizontal)
            
            NavigationLink(isActive: $showEditingView) {
                GoalEditingView(piggy: goal, goalName: goal.name ?? "no name", goalPrice: String("\(goal.goal)"))
            } label: {
                EmptyView()
            }

        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

//struct GoalDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalDetailView(goal: )
//            .environmentObject(HomeViewModel())
//    }
//}

extension GoalDetailView {
    
    private var goalStatistics: some View {
        VStack(spacing: 3) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 50)
                        .foregroundColor(Color.blue.opacity(0.5))
                    
                    Text(String(vm.filteredArray.sum(\.price).asCurrencyWith2Decimals()))
                        .font(.headline)
                }
                ZStack {
                    Circle()
                        .frame(width: 50)
                        .foregroundColor(Color.red.opacity(0.5))
                    
                    Text(String(vm.goalPercentage.asPercentage()))
                        .font(.headline)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 50)
                        .foregroundColor(Color.green.opacity(0.5))
                    
                    Text(String(goal.goal.asCurrencyWith2Decimals()))
                        .font(.headline)
                }
            }
            ProgressBar(value: $vm.goalPercentage)
                .frame(height: 10)
        }
        .frame(height: 80)
        .onAppear {
            vm.goalID = goal.id
            vm.mapFilteredItems()
        }
    }
    
    private var goalProfile: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(vm.getAccentColor())
                
                Text(goal.emoji ?? "🤨")
                    .font(.system(size: 60))
            }
            
            VStack {
                
                Spacer()
                
                Text(goal.name ?? "no name")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 100)
        .padding(.horizontal)
        
    }
    
    private var navigationBar: some View {
        HStack {
            NavigationBackView()
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            
            HStack {
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 40)
                            .foregroundColor(Color.yellow)
                        
                        HStack {
                            Image(systemName: "pin")
                            Text("pin")
                        }
                        .foregroundColor(Color.black)
                    }
                    .frame(width: 100)
                }
                .withPressableStyle()
                
                
                Menu {
                    Button(role: .destructive) {
                        vm.deleteGoal(item: goal)
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label {
                            Text("Delete")
                        } icon: {
                            Image(systemName: "trash")
                        }
                    }
                    
                    Button {
                        showEditingView = true
                    } label: {
                        Label {
                            Text("Edit Goal")
                        } icon: {
                            Image(systemName: "slider.horizontal.3")
                        }

                    }
                    
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 40)
                            .foregroundColor(Color.red)
                        
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color.theme.accent)
                            .font(.headline)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxHeight: 75)
        
    }
    
    
    private var mappedList: some View {
        VStack {
            ForEach(vm.mappedFilteredArray) { section in
                Section {
                    VStack(spacing: 0) {
                        ForEach(section.items) { item in
                            NavigationLink(isActive: $showItemEditing) {
                                EditingView(itemName: (item.name ?? item.id?.uuidString) ?? "You need to repair this Item.", itemPrice: String("\(item.price)"), item: self.$vm.savedEntities[self.vm.savedEntities.firstIndex(of: item)!])
                            } label: {
                                EmptyView()
                            }
                            
                            VStack {
                                HStack {
                                    Text(item.piggyID?.uuidString ?? "No Name")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.theme.accent)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    Text("\(item.price.asCurrencyWith2Decimals())")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.theme.accent)
                                }
                                .frame(height: 40)
                                .padding(.top, 8)
                                Divider()
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    vm.coreDataManager.deleteItem(item: item)
                                    vm.reloadItems()
                                    vm.mapFilteredItems()
                                    vm.updateBilance(goal: goal.goal)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
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
        }
        .foregroundColor(Color.theme.accent)
    }
}

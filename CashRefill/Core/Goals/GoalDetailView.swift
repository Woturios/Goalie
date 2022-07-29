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
    let goal: PiggyEntity
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
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
                                    .foregroundColor(Color.yellow.opacity(0.3))
                                
                                HStack {
                                    Image(systemName: "pin")
                                    Text("pin")
                                }
                                .foregroundColor(Color.black)
                            }
                            .frame(width: 100)
                        }
                        .withPressableStyle()
                        
                        
                        Button {
                            vm.deleteGoal(item: goal)
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 40)
                                    .foregroundColor(Color.red.opacity(0.3))
                                
                                Image(systemName: "trash")
                                    .foregroundColor(Color.red)
                                    .font(.headline)
                            }
                            .withPressableStyle()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    //                .padding(.top, 25)
                }
                .frame(maxHeight: 75)
                
                HStack {
                    ZStack {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(vm.getAccentColor().opacity(0.2))
                        
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
                .padding(.horizontal)
                
                
                mappedList
                
            }
            //            List {
            //                ForEach(vm.filteredArray) { item in
            //                    HStack {
            //                        Text(item.name ?? "no name")
            //                        Spacer()
            //                        Text("\(item.price.asCurrencyWith2Decimals())")
            //
            //                    }
            //                    .font(.headline)
            //                    .foregroundColor(Color.theme.accent)
            //                    .listRowBackground(Color.clear)
            //                }
            //                .onDelete(perform: vm.deleteFiltered)
            //            }
            //            .listStyle(.plain)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal)
        .onAppear {
            //            vm.filterArray(goal: goal)
            vm.mapFilteredItems(goal: goal)
            vm.updateBilance(goal: goal.goal)
        }
        
        
    }
}

//struct GoalDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalDetailView(goal: )
//            .environmentObject(HomeViewModel())
//    }
//}

extension GoalDetailView {
    private var mappedList: some View {
        VStack {
            ForEach(vm.mappedFilteredArray) { section in
                Section {
                    VStack(spacing: 0) {
                        ForEach(section.items) { item in
                            NavigationLink {
                                EditingView(itemName: (item.name ?? item.id?.uuidString) ?? "You need to repair this Item.", itemPrice: String("\(item.price)"), item: item)
                            } label: {
                                VStack {
                                    HStack {
                                        Text(item.name ?? "No Name")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.theme.accent)
                                        Spacer()
                                        Text("\(item.price.asCurrencyWith2Decimals())")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.theme.accent)
                                    }
                                    .frame(height: 40)
                                    Divider()
                                }
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    vm.coreDataManager.deleteItem(item: item)
                                    vm.reloadItems()
                                    vm.mapFilteredItems(goal: goal)
                                    vm.updateBilance(goal: goal.goal)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                                Text("Edit")
                            }
                            //                        .listRowBackground(Color.clear)
                        }
    //                    .onDelete(perform: vm.deletePost)
                        

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
        .listStyle(.plain)
    }
}

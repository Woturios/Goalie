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
            HStack {
                NavigationBackView()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
                Button {

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
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 25)
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
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal)
        .onAppear {
            vm.filterArray(goal: goal)
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
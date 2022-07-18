//
//  CreateNewGoalView.swift
//  CashRefill
//
//  Created by Woturios on 15/07/2022.
//
// This view is a new way to create goals.

import SwiftUI

struct NewGoalView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    
    let filterOptions: [String] = [
        "500", "1000", "2000", "3000", "5000"
    ]
    
    @State private var selection: String = ""
    @State var newGoalPrice: String = ""
    @State var newGoalTitle: String = ""
    
    
    var body: some View {
        ZStack {
            GetBackgroundTheme()
            
            VStack(alignment: .leading) {
                SheetTitleView(title: "Create new goal 🏆")
                
                Text("How much do you want to save?")
                    .font(.headline)
                
                TextField("Name your goal...", text: $newGoalTitle)
                    .withClearButton(text: $newGoalTitle)
                    .withDefaultTextFieldFormatting()
                
                Picker(selection: $selection) {
                    ForEach(filterOptions.indices, id: \.self) { index in
                        Text(filterOptions[index])
                            .tag(filterOptions[index])
                    }
                } label: {
                    Text("Picker")
                }
                .onChange(of: selection, perform: { _ in
                    newGoalPrice = selection
                })
                .pickerStyle(.segmented)
                
                TextField("Add custom goal...", text: $newGoalPrice)
                    .withClearButton(text: $newGoalPrice)
                    .withDefaultTextFieldFormatting()
                    .keyboardType(.numberPad)
                    .onChange(of: newGoalPrice) { _ in
                        selection = newGoalPrice
                    }
                
                Button {
                    if filterOptions.contains(selection) {
                        newGoalPrice = selection
                    }
                    vm.fieldGoalPrice = Double(newGoalPrice) ?? 0
                    selection = "0"
                    vm.addNewGoal(goal: Double(newGoalPrice) ?? 0, name: newGoalTitle, emoji: "😀")
                    newGoalPrice = ""
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text(LocalizedStringKey("SAVE"))
                        .withDefaultButtonFormatting(backgroundColor: vm.getAccentColor(), foregroundColor: Color.theme.reversed)
                }
                .withPressableStyle()


                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView()
            .environmentObject(HomeViewModel())
            .preferredColorScheme(.light)
        
        NewGoalView()
            .environmentObject(HomeViewModel())
            .preferredColorScheme(.dark)

    }
}

//
//  PickerView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 20/05/2022.
//

import SwiftUI

struct PickerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selection: String = ""
    let filterOptions: [String] = [
        "500", "1000", "2000", "3000", "5000"
    ]
    @State var newGoal: String = ""
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.button)
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some View {
        VStack {
            Picker(selection: $selection) {
                ForEach(filterOptions.indices) { index in
                    Text(filterOptions[index])
                        .tag(filterOptions[index])
                }
                .onAppear {
                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(vm.getAccentColor())
                }
            } label: {
                Text("Picker")
            }
            .onChange(of: selection, perform: { newValue in
                newGoal = selection
            })
            .pickerStyle(.segmented)
                        
            TextField("Add your custom goal!", text: $newGoal)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.theme.textFieldColor)
                .cornerRadius(10)
                .keyboardType(.numberPad)
            
            Button {
                if !newGoal.isEmpty {
                    vm.goal = newGoal
                } else if (filterOptions.contains(selection)) {
                    newGoal = selection
                    vm.goal = newGoal
                    selection = "0"
                }
                vm.updateGoalPercentage()
                UIApplication.shared.endEdditing()
                newGoal = ""
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save".uppercased())
                    .font(.headline)
                    .foregroundColor(Color.theme.reversed)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(vm.getAccentColor())
                    .cornerRadius(10)
            }
            
            
            // DEV DATA
            VStack {
                Text("Developer Data")
                Text("selection: \(selection)")
                Text("newGoal: \(newGoal)")
                Text("Curent goal: \(vm.goal)")
                Text("Current percentage: \(vm.goalPercentage)")
            }

        }
        
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}




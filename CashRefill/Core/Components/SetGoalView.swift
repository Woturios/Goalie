//
//  SetGoalView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 20/05/2022.
//

import SwiftUI

struct SetGoalView: View {
    
    // MARK: PROPERTIES
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
    
    // MARK: BODY
    var body: some View {
        VStack {
            picker
            textField
            button
            // DEV DATA
            /*
//            VStack {
//                Text("Developer Data")
//                Text("selection: \(selection)")
//                Text("newGoal: \(newGoal)")
//                Text("Curent goal: \(vm.goal)")
//                Text("Current percentage: \(vm.goalPercentage)")
//            }
             */
        }
    }
}

// MARK: PREVIEWS
struct SetGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SetGoalView()
            .environmentObject(HomeViewModel())
    }
}

// MARK: EXTENSION
extension SetGoalView {
    private var picker: some View {
        Picker(selection: $selection) {
            ForEach(filterOptions.indices, id: \.self) { index in
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
        .padding(.horizontal)
    }

    private var textField: some View {
        TextField(LocalizedStringKey("Add your custom goal!"), text: $newGoal)
            .withClearButton(text: $newGoal)
            .withDefaultTextFieldFormatting()
            .keyboardType(.numberPad)
            .onChange(of: newGoal) { newValue in
                selection = newGoal
            }
            .padding(.horizontal)
    }
    
    private var button: some View {
        Button {
            if !newGoal.isEmpty {
                vm.goal = Double(newGoal) ?? 0
            } else if (filterOptions.contains(selection)) {
                newGoal = selection
                vm.goal = Double(newGoal) ?? 0
                selection = "0"
            }
            vm.updateGoalPercentage()
            UIApplication.shared.endEdditing()
            newGoal = ""
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(LocalizedStringKey("SAVE"))
                .withDefaultButtonFormatting(backgroundColor: vm.getAccentColor(), foregroundColor: Color.theme.reversed)
                .padding(.horizontal)
        }
        .withPressableStyle()
    }
}





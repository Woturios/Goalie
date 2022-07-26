//
//  AddView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import SwiftUI

struct AddView: View {
    
    // MARK: PROPERTIES
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    
//    @State var selectedPiggy: PiggyEntity
    
    // MARK: BODY
    var body: some View {
        ZStack {
            // Background layer
            GetBackgroundTheme()
            
            // Content layer
            VStack(alignment: .leading) {
                NavigationBackView()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
                Text("Add new item:")
                    .font(.title)
                    .fontWeight(.bold)

                Text(vm.selectedGoal?.uppercased() ?? "Select goal".uppercased())
                    .foregroundColor(vm.getAccentColor())
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .withDefaultTextFieldFormatting()
                    .onTapGesture {
                        vm.isPresented = true
                    }
                    .sheet(isPresented: $vm.isPresented) {
                        selectGoalView()
                    }

                AddEditFormView(textFieldName: $vm.textFieldName,
                                textFieldPrice: $vm.textFieldPrice,
                                itemTitle: "Add new item...",
                                priceTitle: "Add price...")
                button
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
    }
}

// MARK: PREVIEW
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.light)
        }

        NavigationView {
            AddView()
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

// MARK: EXTENSION
extension AddView {
    private var pageTitle: some View {
        Text("Add new item:")
            .foregroundColor(Color.theme.accent)
            .font(.title)
            .fontWeight(.semibold)
            .padding(.horizontal)
    }
    
    private var button: some View {
        Button {
            guard !vm.textFieldName.isEmpty && !vm.textFieldPrice.isEmpty else { return vm.alertIsToggled = true }
            vm.addNewItemToList()
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(LocalizedStringKey("ADD TO MY LIST 🥳"))
                .withDefaultButtonFormatting(backgroundColor: vm.getAccentColor(), foregroundColor: Color.theme.reversed)
        }
        .withPressableStyle()
        .alert("Oh, no! 😰😱🥶", isPresented: $vm.alertIsToggled) {
            
        } message: {
            Text("Please, type the name and price of the item! 🫡")
        }
    }
}


struct selectGoalView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        VStack {
            ForEach(vm.goalsArray) { goal in
                Text(goal.name ?? "no name")
                    .foregroundColor(vm.getAccentColor())
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .withDefaultTextFieldFormatting()
                    .onTapGesture {
                        vm.goalID = goal.id
                        vm.selectedGoal = goal.name
                    }
            }
        }
    }
}

struct editGoalView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    let item: PostEntity
    
    var body: some View {
        VStack {
            ForEach(vm.goalsArray) { goal in
                Text(goal.name ?? "no name")
                    .foregroundColor(vm.getAccentColor())
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .withDefaultTextFieldFormatting()
                    .onTapGesture {
//                        vm.goalID
                        item.piggyID = goal.id
                        vm.selectedGoal = goal.name
                    }
            }
        }
    }
}


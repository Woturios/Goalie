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
    @State var selectedPiggy: UUID
    
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
                    .padding(.top, 25)
                
                Text("Add new item:")
                    .font(.title)
                    .fontWeight(.bold)

                
                Picker(selection: $selectedPiggy) {
                    ForEach(vm.goalsArray) { goal in
                        Text(goal.name ?? "no name")
                            .font(.headline)
                            .foregroundColor(Color.theme.accent)
                    }
                } label: {
                    Text("Select Piggy Box")
                }
                .onChange(of: selectedPiggy, perform: { newValue in
                    <#code#>
                })
                .tint(Color.theme.accent)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .withDefaultTextFieldFormatting()

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
//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            AddView(, selectedPiggy: <#PiggyEntity#>)
//                .environmentObject(HomeViewModel())
//                .preferredColorScheme(.light)
//        }
//
//        NavigationView {
//            AddView(, selectedPiggy: <#PiggyEntity#>)
//                .environmentObject(HomeViewModel())
//                .preferredColorScheme(.dark)
//        }
//    }
//}

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
            vm.addNewItemToList(piggy: selectedPiggy)
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



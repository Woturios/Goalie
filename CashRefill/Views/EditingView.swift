//
//  EditingView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 24/05/2022.
//

import SwiftUI

struct EditingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    var entity: PostEntity

    var body: some View {
        ZStack {
            RadialGradient(colors: [vm.getBackgroundColor().opacity(0.3), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    CircleButton(buttonName: "xmark")
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                .padding()
                Spacer()
                Text("Edit your list item:")
                    .foregroundColor(Color.theme.accent)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                AddEditFormView(addItemTitle: "Edit item name...", addPriceTitle: "Edit price...")
                button
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
}

extension EditingView {
    private var button: some View {
        Button {
            guard !vm.textFieldName.isEmpty && !vm.textFieldPrice.isEmpty else { return vm.alertIsToggled = true }
            let fieldPrice = String(vm.textFieldPrice.replacingOccurrences(of: ",", with: "."))
            vm.textFieldPrice = fieldPrice
            vm.updatePost(entity: entity)
            UIApplication.shared.endEdditing()
            vm.textFieldName = ""
            vm.textFieldPrice = ""
            vm.portfolioSummary = vm.savedEntities.sum(\.price)
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Submit your changes 👍".uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.reversed)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.theme.button)
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .alert("Oh, no! 😰😱🥶", isPresented: $vm.alertIsToggled) {
            
        } message: {
            Text("Please, type the name and price of the item! 🫡")
        }

    }
}

//struct EditingView_Previews: PreviewProvider {
//
//
//
//    static var previews: some View {
//        EditingView(entity: vm.savedEntities.first!)
//    }
//}

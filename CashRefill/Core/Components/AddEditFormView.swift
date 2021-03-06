//
//  AddEditFormView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 23/05/2022.
//

import SwiftUI

struct AddEditFormView: View {
    
    // MARK: PROPERTIES
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    var addItemTitle: LocalizedStringKey
    var addPriceTitle: LocalizedStringKey
    @FocusState private var firstFocus: Bool
    
    // MARK: BODY
    var body: some View {
        VStack(spacing: 10) {
            TextField(addItemTitle, text: $vm.textFieldName)
                .withClearButton(text: $vm.textFieldName)
                .focused($firstFocus)
                .withDefaultTextFieldFormatting()
                .keyboardType(.alphabet)
            
            TextField(addPriceTitle, text: $vm.textFieldPrice)
                .withClearButton(text: $vm.textFieldPrice)
                .withDefaultTextFieldFormatting()
                .keyboardType(.decimalPad)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                firstFocus = true
            }
        }
    }
}

// MARK: PREVIEWS
struct AddEditFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditFormView(addItemTitle: "", addPriceTitle: "")
    }
}

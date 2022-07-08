//
//  AddEditFormView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 23/05/2022.
//

import SwiftUI

struct AddEditFormView: View {
    
    // MARK: PROPERTIES
    @Binding var textFieldName: String
    @Binding var textFieldPrice: String
    var itemTitle: LocalizedStringKey
    var priceTitle: LocalizedStringKey
    @FocusState private var firstFocus: Bool
    
    // MARK: BODY
    var body: some View {
        VStack(spacing: 10) {
            TextField(itemTitle, text: $textFieldName)
                .withClearButton(text: $textFieldName)
                .focused($firstFocus)
                .withDefaultTextFieldFormatting()
                .keyboardType(.alphabet)
            
            TextField(priceTitle, text: $textFieldPrice)
                .withClearButton(text: $textFieldPrice)
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
//        AddEditFormView(itemTitle: "", priceTitle: "")
        AddEditFormView(textFieldName: .constant("title"), textFieldPrice: .constant("price"), itemTitle: "name", priceTitle: "price")
    }
}

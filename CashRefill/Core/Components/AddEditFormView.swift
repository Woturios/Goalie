//
//  AddEditFormView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 23/05/2022.
//

import SwiftUI

struct AddEditFormView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    var addItemTitle: String
    var addPriceTitle: String
    @FocusState private var firstFocus: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            TextField(addItemTitle, text: $vm.textFieldName)
                .focused($firstFocus).modifier(ClearButton(text: $vm.textFieldName))
//                .focused($fieldInFocus, equals: .itemTitle)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.theme.textFieldColor)
                .cornerRadius(10)
                .padding(.horizontal)
                .keyboardType(.alphabet)
            
            TextField(addPriceTitle, text: $vm.textFieldPrice).modifier(ClearButton(text: $vm.textFieldPrice))
//                .focused($fieldInFocus, equals: .itemPrice)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.theme.textFieldColor)
                .cornerRadius(10)
                .padding(.horizontal)
                .keyboardType(.decimalPad)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                firstFocus = true
            }
        }
    }
}

struct AddEditFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditFormView(addItemTitle: "", addPriceTitle: "")
    }
}

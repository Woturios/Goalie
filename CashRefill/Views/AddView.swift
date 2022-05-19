//
//  AddView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    @State var textFieldName: String
    @State var textFieldPrice: Double
    @State var portfolioSummary: Double
    
    var body: some View {
        VStack() {
            TextField("Dodaj nazwę płyty...", text: $textFieldName)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color("SecondaryColor"))
                .cornerRadius(10)
                .padding(.horizontal)
                .keyboardType(.alphabet)
            
            TextField("Podaj oszczędzoną kwotę...", value: $textFieldPrice, format: .number)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color("SecondaryColor"))
                .cornerRadius(10)
                .padding(.horizontal)
                .keyboardType(.decimalPad)
            
            Button {
                guard !textFieldName.isEmpty else { return }
                vm.addPost(text: textFieldName, price: textFieldPrice)
                UIApplication.shared.endEdditing()
                textFieldName = ""
                textFieldPrice = 0
                portfolioSummary = vm.savedEntities.sum(\.price)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Dodaj do mojej listy")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .navigationBarHidden(false)
        .navigationTitle("Dodaj nową rzecz:")
        .navigationBarBackButtonHidden(false)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView(textFieldName: "First", textFieldPrice: 10, portfolioSummary: 100)
        }
    }
}

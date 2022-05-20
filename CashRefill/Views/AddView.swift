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
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Back")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.accentColor)
                CircleButton(buttonName: "arrow.backward.circle.fill")
            }
                .padding(.horizontal)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Text("Add new item:")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            VStack(spacing: 10) {
                TextField("Add new item...", text: $textFieldName)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color("SecondaryColor"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .keyboardType(.alphabet)
                
                TextField("Add price...", value: $textFieldPrice, format: .number)
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
                    Text("Add to my list 🥳")
                        .font(.headline)
                        .foregroundColor(Color("ReversedPrimary"))
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView(textFieldName: "First", textFieldPrice: 10, portfolioSummary: 100)
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.light)
        }
        
        NavigationView {
            AddView(textFieldName: "First", textFieldPrice: 10, portfolioSummary: 100)
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

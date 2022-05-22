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
    @State var textFieldPrice: String
    @State var portfolioSummary: Double
    
    var body: some View {
        ZStack {
            // Background layer
            if vm.selectedTab == 0 {
                RadialGradient(colors: [Color.blue.opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            } else if vm.selectedTab == 1 {
                RadialGradient(colors: [Color.orange.opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            } else {
                RadialGradient(colors: [Color.green.opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            }
            
            // Content layer
            VStack(alignment: .leading) {
                navigationView
                pageTitle
                addItemForm
                Spacer()
            }
            .navigationBarHidden(true)
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView(textFieldName: "First", textFieldPrice: "10", portfolioSummary: 100)
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.light)
        }
        
        NavigationView {
            AddView(textFieldName: "First", textFieldPrice: "10", portfolioSummary: 100)
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

extension AddView {
    private var navigationView: some View {
        HStack {
            Spacer()
            Text("Back")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(vm.accentColor)
            CircleButton(buttonName: "arrow.backward.circle.fill")
        }
            .padding(.horizontal)
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
            }
    }
    
    private var pageTitle: some View {
        Text("Add new item:")
            .foregroundColor(vm.accentColor)
            .font(.title)
            .fontWeight(.semibold)
            .padding(.horizontal)
    }
    
    private var addItemForm: some View {
        VStack(spacing: 10) {
            TextField("Add new item...", text: $textFieldName)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.theme.textFieldColor)
                .cornerRadius(10)
                .padding(.horizontal)
                .keyboardType(.alphabet)
            
//            TextField("Add price...", value: $textFieldPrice, format: .number)
            TextField("Add price", text: $textFieldPrice)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.theme.textFieldColor)
                .cornerRadius(10)
                .padding(.horizontal)
                .keyboardType(.decimalPad)
            
            Button {
                guard !textFieldName.isEmpty else { return }
                let fieldPrice = String(textFieldPrice.replacingOccurrences(of: ",", with: "."))
                vm.addPost(text: textFieldName, price: fieldPrice)
                UIApplication.shared.endEdditing()
                textFieldName = ""
                textFieldPrice = ""
                portfolioSummary = vm.savedEntities.sum(\.price)
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add to my list 🥳".uppercased())
                    .font(.headline)
                    .foregroundColor(Color.theme.reversed)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(vm.accentColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
    }
}

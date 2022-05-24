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
    
    var body: some View {
        ZStack {
            // Background layer
            RadialGradient(colors: [vm.getBackgroundColor().opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            
            // Content layer
            VStack(alignment: .leading) {
                navigationView
                pageTitle
                AddEditFormView(addItemTitle: "Add new item...", addPriceTitle: "Add price...")
                button
                Spacer()
            }
            .onAppear(perform: {
                if vm.editingSheet == false {
                    vm.textFieldName = ""
                    vm.textFieldPrice = ""
                }
            })
            .navigationBarHidden(true)
        }
        
    }
}

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

extension AddView {
    private var navigationView: some View {
        HStack {
            Spacer()
            Text("Back")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.accent)
            CircleButton(buttonName: "arrow.backward.circle.fill")
        }
            .padding(.horizontal)
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
            }
    }
    
    private var pageTitle: some View {
        Text("Add new item:")
            .foregroundColor(Color.theme.accent)
            .font(.title)
            .fontWeight(.semibold)
            .padding(.horizontal)
    }
    
    private var button: some View {
        Button {
            vm.addNewItemToList()
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Add to my list 🥳".uppercased())
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


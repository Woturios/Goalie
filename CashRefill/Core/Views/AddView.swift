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
            RadialGradient(colors: [vm.getAccentColor().opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            
            // Content layer
            VStack(alignment: .leading) {
                //                NavigationBackView()
                //                    .onTapGesture {
                //                        self.presentationMode.wrappedValue.dismiss()
                //                    }
                //                pageTitle
                AddEditFormView(addItemTitle: "Add new item...", addPriceTitle: "Add price...")
                button
                Spacer()
            }
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Add new item:")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackView()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
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
            Text("Add to my list 🥳".uppercased())
                .withDefaultButtonFormatting(backgroundColor: vm.getAccentColor(), foregroundColor: Color.theme.reversed)
                .padding(.horizontal)
        }
        .withPressableStyle()
        .alert("Oh, no! 😰😱🥶", isPresented: $vm.alertIsToggled) {
            
        } message: {
            Text("Please, type the name and price of the item! 🫡")
        }
    }
}



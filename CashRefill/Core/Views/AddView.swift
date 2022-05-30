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
    
    // MARK: BODY
    var body: some View {
        ZStack {
            // Background layer
            RadialGradient(colors: [vm.getAccentColor().opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            
            // Content layer
            VStack(alignment: .leading) {
                AddEditFormView(addItemTitle: LocalizedStringKey("Add new item..."), addPriceTitle: LocalizedStringKey("Add price..."))
                button
                Spacer()
            }
            .padding(.horizontal)
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

// MARK: PREVIEW
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
            vm.addNewItemToList()
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



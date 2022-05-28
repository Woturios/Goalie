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
    @State var itemName: String
    @State var itemPrice: String
    @FocusState private var firstFocus: Bool
    let item: PostEntity
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [vm.getAccentColor().opacity(0.3), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Edit your list item:")
                    .foregroundColor(Color.theme.accent)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                VStack(spacing: 10) {
                    TextField(item.name ?? "", text: $itemName)
                        .focused($firstFocus)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(Color.theme.textFieldColor)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .keyboardType(.alphabet)
                    
                    TextField(String("\(item.price)"), text: $itemPrice)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(Color.theme.textFieldColor)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .keyboardType(.decimalPad)
                    button
                    Spacer()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        firstFocus = true
                    }
                }
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
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


extension EditingView {
    private var button: some View {
        Button {
            //            guard !vm.textFieldName.isEmpty && !vm.textFieldPrice.isEmpty else { return vm.alertIsToggled = true }
            if !itemName.isEmpty && !itemPrice.isEmpty {
                item.name = itemName
                item.price = Double("\(itemPrice)") ?? 0
                vm.updatePost()
                vm.reloadItems()
                vm.updateBilance()
            }
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Submit your changes 👍".uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.reversed)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(vm.getAccentColor())
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .alert("Oh, no! 😰😱🥶", isPresented: $vm.alertIsToggled) {
            
        } message: {
            Text("Please, type the name and price of the item! 🫡")
        }
        
    }
}

struct EditingView_Previews: PreviewProvider {
    static var previews: some View {
        let item = PostEntity()
        EditingView(itemName: "", itemPrice: "0", item: item)
            .environmentObject(HomeViewModel())
    }
}

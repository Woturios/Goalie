//
//  EditingView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 24/05/2022.
//

import SwiftUI

struct EditingView: View {
    
    // MARK: PROPERTIES
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel
    @State var itemName: String
    @State var itemPrice: String
    @FocusState private var firstFocus: Bool
    let item: PostEntity
    
    // MARK: BODY
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
                        .withClearButton(text: $itemName)
                        .focused($firstFocus)
                        .withDefaultTextFieldFormatting()
                        .padding(.horizontal)
                        .keyboardType(.alphabet)
                    
                    TextField(String("\(item.price)"), text: $itemPrice)
                        .withClearButton(text: $itemPrice)
                        .withDefaultTextFieldFormatting()
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

// MARK: EXTENSION
extension EditingView {
    private var button: some View {
        Button {
            if !itemName.isEmpty && !itemPrice.isEmpty {
                item.name = itemName
                item.price = Double("\(itemPrice.replacingOccurrences(of: ",", with: "."))") ?? 0
                vm.updatePost()
                vm.reloadItems()
                vm.updateBilance()
            }
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(LocalizedStringKey("SUBMIT YOUR CHANGES 👍"))
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

// MARK: PREVIEW
//struct EditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditingView(itemName: "name", itemPrice: "23", item: PostEntity.indice)
//    }
//}

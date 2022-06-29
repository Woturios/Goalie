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
            GetBackgroundTheme()
            
            VStack(alignment: .leading) {
                NavigationBackView()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.top, 25)
                
                Text("Edit your list item:")
                    .foregroundColor(Color.theme.accent)
                    .font(.title)
                    .fontWeight(.semibold)
                
                VStack(spacing: 10) {
                    TextField(item.name ?? "", text: $itemName)
                        .withClearButton(text: $itemName)
                        .focused($firstFocus)
                        .withDefaultTextFieldFormatting()
                        .keyboardType(.alphabet)
                    
                    TextField(String("\(item.price)"), text: $itemPrice)
                        .withClearButton(text: $itemPrice)
                        .withDefaultTextFieldFormatting()
                        .keyboardType(.decimalPad)
                    button
                    HStack {
                        Text("Created: ")
                            .foregroundColor(Color.primary.opacity(0.3))
                        Text("\(item.date?.formatted(date: .long, time: .shortened) ?? "")")
                            .foregroundColor(Color.gray)
                            
                    }
                    .frame(height: 55)
                    .withDataPresentationFieldStyle()
                    Spacer()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        firstFocus = true
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
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

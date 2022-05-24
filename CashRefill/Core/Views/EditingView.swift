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
    let item: PostEntity
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [vm.getBackgroundColor().opacity(0.3), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    CircleButton(buttonName: "arrow.backward.circle.fill")
//                    CircleButton(buttonName: "xmark")
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                .padding()
                Spacer()
                Text("Edit your list item:")
                    .foregroundColor(Color.theme.accent)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                VStack(spacing: 10) {
                    TextField(item.name ?? "", text: $itemName)
                    //                            .focused($firstFocus)
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
                //                    .onAppear {
                //                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                //                            firstFocus = true
                //                        }
                //                    }
            }
            
        }
        .navigationBarHidden(true)
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
            //            vm.textFieldName = ""
            //            vm.textFieldPrice = ""
            //            vm.portfolioSummary = vm.savedEntities.sum(\.price)
                        self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Submit your changes 👍".uppercased())
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

struct EditingView_Previews: PreviewProvider {
    static var previews: some View {
        let item = PostEntity()
        EditingView(itemName: "", itemPrice: "0", item: item)
            .environmentObject(HomeViewModel())
    }
}

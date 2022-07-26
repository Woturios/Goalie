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
                
                ScrollView(showsIndicators: false) {
                    Text("Edit your list item:")
                        .foregroundColor(Color.theme.accent)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 10) {
                        
                        Text(vm.goalsArray.first(where: { $0.id == item.piggyID })?.name?.uppercased() ?? "Select goal".uppercased())
                            .foregroundColor(vm.getAccentColor())
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .withDefaultTextFieldFormatting()
                            .onTapGesture {
                                vm.isPresented = true
                            }
                            .sheet(isPresented: $vm.isPresented) {
                                editGoalView(item: item)
                            }
//                            .onAppear {
//                                guard let goalPassedId = item.piggyID else { return }
//                                vm.goalID = goalPassedId
//                                if let goalName = vm.goalsArray.first(where: { $0.id == goalPassedId }) {
//                                    vm.selectedGoal = goalName.name
//                                }
//                            }
                        
                        AddEditFormView(textFieldName: $itemName,
                                        textFieldPrice: $itemPrice,
                                        itemTitle: LocalizedStringKey("Edit item..."),
                                        priceTitle: LocalizedStringKey("Edit price..."))
                        button
                        HStack {
                            Text("Created: ")
                                .foregroundColor(Color.primary.opacity(0.3))
                            Text("\(item.date?.formatted(date: .long, time: .shortened) ?? "")")
                                .foregroundColor(Color.gray)
                                
                        }
                        .frame(height: 55)
                        .withDataPresentationFieldStyle()
                        deleteButton
                        Spacer()
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
    
    private var deleteButton: some View {
        Button {
            vm.coreDataManager.deleteItem(item: item)
            vm.reloadItems()
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(LocalizedStringKey("DELETE 😡"))
                .withDefaultButtonFormatting(backgroundColor: Color.red)
        }

    }
}

 //MARK: PREVIEW
//struct EditingView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditingView(itemName: <#String#>, itemPrice: <#String#>, item: <#PostEntity#>)
//            .environmentObject(HomeViewModel())
//    }
//}

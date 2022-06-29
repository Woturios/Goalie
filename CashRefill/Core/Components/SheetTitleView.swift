//
//  SheetTitleView.swift
//  CashRefill
//
//  Created by Woturios on 28/06/2022.
//

import SwiftUI

struct SheetTitleView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let title: String

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
            .padding(.top)
            
            Text(title)
                .foregroundColor(Color.theme.accent)
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


//struct SheetTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        SheetTitleView(presentationMode: , title: "Hello, world!")
//    }
//}

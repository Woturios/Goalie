//
//  ChangeCurrencyView.swift
//  CashRefill
//
//  Created by Woturios on 29/06/2022.
//

import SwiftUI

struct ChangeCurrencyView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            GetBackgroundTheme()
            
            VStack(alignment: .leading, spacing: 10) {
                NavigationBackView()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Text("Change Currency")
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView {
                    Text("""
                            Goalie is Currently supporting three Currencies:
                            🇵🇱 Polish zloty PLN
                            🇺🇸 US Dollar $
                            🇪🇺 European Euro €
                            
                            To change currency follow this steps:
                            
                            ⚙️ Open Settings App on your device.
                            🔍 Search for "Language & Region"
                            🌍 Change Region to country that uses Currency you want!
                            """)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.theme.reversed.opacity(0.2))
                .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}
struct ChangeCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeCurrencyView()
    }
}

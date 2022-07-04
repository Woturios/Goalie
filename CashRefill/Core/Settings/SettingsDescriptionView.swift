//
//  SettingsDescriptionView.swift
//  CashRefill
//
//  Created by Woturios on 29/06/2022.
//

import SwiftUI

struct SettingsDescriptionView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let title: LocalizedStringKey
    let description: LocalizedStringKey
    
    var body: some View {
        ZStack {
            GetBackgroundTheme()
            
            VStack(alignment: .center, spacing: 10) {
                NavigationBackView()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                    ScrollView {
                        Text(description)
                    }
                }
                .frame(maxWidth: 500)
                
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
        SettingsDescriptionView(
            title: "Change currency 💰",
            description: """
                            To change currency follow this steps:
                            
                            ⚙️ Open Settings App on your device.
                            🔍 Search for "Language & Region"
                            🌍 Change Region to country that uses Currency you want!
                            
                            Changing region may affect the format of dates and distances on your phone. However you can allways change them back manually.
                            """)
            .environmentObject(HomeViewModel())
    }
}

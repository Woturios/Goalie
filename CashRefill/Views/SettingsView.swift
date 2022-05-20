//
//  SettingsView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 20/05/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("Back")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.accentColor)
                CircleButton(buttonName: "arrow.backward.circle.fill")
            }
            .padding(.horizontal)
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
            }
            
            
            Text("Set your goal 🏆")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)
                        
            VStack(alignment: .leading ,spacing: 10) {
                Text("How much do you want to save?")
                    .font(.headline)
                    .fontWeight(.semibold)
                PickerView()
                Spacer()
                Text("Instead of spending money on things you don't really need, save them for something you really care about.")
                    .font(.headline)
                    .foregroundColor(Color.secondary)
                    .bold()
                    .multilineTextAlignment(.center)
                Spacer()
                
            }
            .padding()
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.light)
        }
        
        NavigationView {
            SettingsView()
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

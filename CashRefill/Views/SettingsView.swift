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
        ZStack {
            // Background layer
            Color.theme.background.ignoresSafeArea()
            
            // Content layer
            VStack(alignment: .leading) {
                navBar
                pageTitle
                VStack(alignment: .leading ,spacing: 10) {
                    setGoalTitle
                    PickerView()
                    Spacer()
                    smartTip
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
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

extension SettingsView {
    private var navBar: some View {
        HStack {
            Spacer()
            Text("Back")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.accent)
            CircleButton(buttonName: "arrow.backward.circle.fill")
        }
        .padding(.horizontal)
        .onTapGesture {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var pageTitle: some View {
        Text("Set your goal 🏆")
            .foregroundColor(Color.theme.accent)
            .font(.title)
            .fontWeight(.semibold)
            .padding(.horizontal)
    }
    
    private var setGoalTitle: some View {
        Text("How much do you want to save?")
            .font(.headline)
            .fontWeight(.semibold)
    }
    
    private var smartTip: some View {
        Text("Instead of spending money on things you don't really need, save them for something you really care about.")
            .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
            .bold()
            .multilineTextAlignment(.center)
    }
}

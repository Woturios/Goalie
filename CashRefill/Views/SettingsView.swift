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
            if vm.selectedTab == 0 {
                RadialGradient(colors: [Color.blue.opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            } else if vm.selectedTab == 1 {
                RadialGradient(colors: [Color.orange.opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            } else {
                RadialGradient(colors: [Color.green.opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            }
            
            // Content layer
            VStack(alignment: .leading) {
                navBar
                pageTitle
                VStack(alignment: .center ,spacing: 10) {
                    setGoalTitle
                    PickerView()
                    Spacer()
                    if vm.goal == "0.0001" {
                        smartTip
                    } else {
                        Text("Your current goal is \(vm.goal) zł")
                            .font(.headline)
                            .bold()
                    }
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
                .foregroundColor(vm.accentColor)
            CircleButton(buttonName: "arrow.backward.circle.fill")
        }
        .padding(.horizontal)
        .onTapGesture {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    private var pageTitle: some View {
        Text("Set your goal 🏆")
            .foregroundColor(vm.accentColor)
            .font(.title)
            .fontWeight(.semibold)
            .padding(.horizontal)
    }
    
    private var setGoalTitle: some View {
        HStack {
            Text("How much do you want to save?")
                .font(.headline)
                .fontWeight(.semibold)
            Spacer()
        }
    }
    
    private var smartTip: some View {
        VStack {
            Text("Add your first goal!")
                .font(.title)
                .bold()
            Text("Instead of spending money on things you don't really need, save them for something you really care about.")
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
                .bold()
                .multilineTextAlignment(.center)
        }
    }
}

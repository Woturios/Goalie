//
//  SettingsView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 20/05/2022.
//

import SwiftUI

struct GoalView: View {
    
    // MARK: PROPERTIES
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var vm: HomeViewModel

    // MARK: BODY
    var body: some View {
        ZStack {
            // Background layer
            RadialGradient(colors: [vm.getAccentColor().opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
            
            // Content layer
            VStack(alignment: .leading) {
                navBar
                pageTitle
                VStack(alignment: .center ,spacing: 10) {
                    setGoalTitle
                        .padding(.horizontal)
                    SetGoalView()
                    Spacer()
                    if vm.goal == 0 {
                        smartTip
                    } else {
                        Text("Your current goal is \(vm.goal.asCurrencyWith0Decimals())")
                            .font(.headline)
                            .bold()
                    }
                    Spacer()
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GoalView()
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.light)
        }
        
        NavigationView {
            GoalView()
                .environmentObject(HomeViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

// MARK: EXTENSION
extension GoalView {
    private var navBar: some View {
        HStack {
            Spacer()
            Image(systemName: "xmark")
                .font(.title)
                .frame(width: 50, height: 50)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var pageTitle: some View {
        Text("Set your goal 🏆")
            .foregroundColor(Color.theme.accent)
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

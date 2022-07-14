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
            GetBackgroundTheme()
            
            // Content layer
            VStack(alignment: .leading) {
                SheetTitleView(title: "Set your goal 🏆")
                VStack(alignment: .center ,spacing: 10) {
                    setGoalTitle
                    SetGoalView()
                    if vm.goal == 0 {
                        smartTip
                    } else {
                        Text("Your current goal is \(vm.goal.asCurrencyWith0Decimals())")
                            .foregroundColor(Color.primary.opacity(0.5))
                            .frame(height: 55)
                            .withDataPresentationFieldStyle()
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
    }
}

// MARK: PREVIEW
struct GoalView_Previews: PreviewProvider {
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
        .padding(.top)
    }
    
    private var pageTitle: some View {
        Text("Set your goal 🏆")
            .foregroundColor(Color.theme.accent)
            .font(.title)
            .fontWeight(.semibold)
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
        VStack(alignment: .leading) {
            Text("Add your first goal!")
                .foregroundColor(Color.primary.opacity(0.5))
                .font(.title)
                .bold()
            Text("Instead of spending money on things you don't really need, save them for something you really care about.")
                .foregroundColor(Color.primary.opacity(0.4))
                .bold()
                .multilineTextAlignment(.leading)
        }
        .padding()
        .withDataPresentationFieldStyle()
    }
}


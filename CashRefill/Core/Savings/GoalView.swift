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
                navBar
                pageTitle
                VStack(alignment: .center ,spacing: 10) {
                    setGoalTitle
                        .padding(.horizontal)
                    SetGoalView()
                    Spacer()
                    VStack {
                        Text("Select your theme!")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        
                        HStack {
                            Button {
                                vm.selectedTheme = 3
                            } label: {
                                BackgroundGradient(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color("PrimaryGradient"))
                                    .cornerRadius(10)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .scaleEffect((vm.selectedTheme == 3) ? 0.9 : 1)
                            }
                            .buttonStyle(.plain)

                            Button {
                                vm.selectedTheme = 1
                            } label: {
                                BottomGradientBackground(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color("PrimaryGradient"))
                                    .cornerRadius(10)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .scaleEffect((vm.selectedTheme == 1) ? 0.9 : 1)
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                vm.selectedTheme = 2
                            } label: {
                                AngularGradientBackground(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color("PrimaryGradient"))
                                    .cornerRadius(10)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .scaleEffect((vm.selectedTheme == 2) ? 0.9 : 1)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .frame(height: 170)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding()
                    
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

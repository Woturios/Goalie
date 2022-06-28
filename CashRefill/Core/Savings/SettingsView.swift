//
//  SettingsView.swift
//  CashRefill
//
//  Created by Woturios on 28/06/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.theme.reversed.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Settings")
                    .foregroundColor(Color.primary)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 25)
                
                VStack {
                    Text("Select your theme!")
                        .font(.headline)
                        .foregroundColor(Color.primary)
                    
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
                .padding()

                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(HomeViewModel())
    }
}

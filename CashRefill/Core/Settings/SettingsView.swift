//
//  SettingsView.swift
//  CashRefill
//
//  Created by Woturios on 28/06/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            GetBackgroundTheme()
            
            VStack(alignment: .leading, spacing: 3) {
                NavigationBackView()
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
                donateView
                
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 10) {
                    selectThemeView
                    changeCurrencyButtonView
                    changeLanguageButtonView
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.light)
            .environmentObject(HomeViewModel())
        
        SettingsView()
            .preferredColorScheme(.dark)
            .environmentObject(HomeViewModel())
        
    }
}

extension SettingsView {
    
    private var donateView: some View {
        NavigationLink {
            DonateView()
        } label: {
            HStack {
                VStack {
                    Text("Help us to improve Goalie!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.accent.opacity(0.8))
                    Text("Donate to us in Cryptocurrency!")
                        .font(.headline)
                        .foregroundColor(Color.theme.accent.opacity(0.6))
                }
                Image(systemName: "hand.tap")
                    .font(.custom("tap", size: 40))
                    .foregroundColor(Color.theme.accent.opacity(0.8))
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 130)
            .background(Color.yellow.opacity(0.2))
            .border(Color.yellow.opacity(0.6), width: 5)
            .cornerRadius(10)
        }
        
    }
    
    private var changeCurrencyButtonView: some View {
        NavigationLink {
            SettingsDescriptionView(
                title: "Change currency",
                description: """
                            To change currency follow this steps:
                            
                            ⚙️ Open Settings App on your device.
                            🔍 Search for "Language & Region"
                            🌍 Change Region to country that uses currency you want!
                            
                            Changing region may affect the format of dates and distances on your phone. However you can allways change them back manually.
                            """)
        } label: {
            SettingsButtonView(name: "Change Currency")
        }
    }
    
    private var changeLanguageButtonView: some View {
        NavigationLink {
            SettingsDescriptionView(
                title: "Change language",
                description: """
                            Goalie is curently supporting three languages:
                            
                            🇺🇸 English
                            🇵🇱 Polish
                            🇩🇪 German
                            
                            To change language go to Settings app and search for Goalie. You will se a setting to change app language.
                            """)
        } label: {
            SettingsButtonView(name: "Change Language")
        }
        
    }
    
    private var selectThemeView: some View {
        VStack {
            Text("Select your theme!")
                .frame(height: 55)
                .withDataPresentationFieldStyle()
                .foregroundColor(Color.primary)
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(vm.getAccentColor().opacity(0.2))
                
                VStack {
                    HStack {
                        Button {
                            vm.selectedTheme = 3
                        } label: {
                            BackgroundGradient(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color("PrimaryGradient"))
                                .cornerRadius(10)
                                .frame(maxWidth: 100, maxHeight: 100)
                                .scaleEffect((vm.selectedTheme == 3) ? 0.9 : 1)
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            vm.selectedTheme = 1
                        } label: {
                            BottomGradientBackground(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color("PrimaryGradient"))
                                .cornerRadius(10)
                                .frame(maxWidth: 100, maxHeight: 100)
                                .scaleEffect((vm.selectedTheme == 1) ? 0.9 : 1)
                        }
                        .buttonStyle(.plain)
                        
                        Button {
                            vm.selectedTheme = 2
                        } label: {
                            AngularGradientBackground(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color("PrimaryGradient"))
                                .cornerRadius(10)
                                .frame(maxWidth: 100, maxHeight: 100)
                                .scaleEffect((vm.selectedTheme == 2) ? 0.9 : 1)
                        }
                        .buttonStyle(.plain)
                    }
                    Button {
                        vm.selectedTheme = 4
                    } label: {
                        ZStack {
                            Color.theme.reversed
                                .cornerRadius(10)
                                .frame(maxWidth: 315, maxHeight: 100)
                                .scaleEffect((vm.selectedTheme == 4) ? 0.9 : 1)
                            Text("Minimalist theme")
                                .font(.headline)
                                .foregroundColor(vm.getAccentColor())
                        }
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding()
            }
            .frame(maxHeight: 250)
            
            VStack {
                Text("Select background theme you will be using in goalie app.")
            }
            .padding()
            .foregroundColor(Color.primary.opacity(0.5))
            .withDataPresentationFieldStyle()
        }
    }
}

struct SettingsButtonView: View {
    let name: LocalizedStringKey
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            CircleButton(buttonName: "arrow.forward.circle")
        }
        .padding(.horizontal)
        .withDefaultButtonFormatting(backgroundColor: Color.theme.reversed, foregroundColor: Color.primary)
    }
}

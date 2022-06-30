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
//        NavigationView {
            ZStack {
                GetBackgroundTheme()
                
                VStack(alignment: .leading, spacing: 3) {
                    NavigationBackView()
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    Text("Settings")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 10) {
    //                    SheetTitleView(title: "Settings")
                        selectThemeView
                        changeCurrencyButtonView
                        Spacer()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
//        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(HomeViewModel())
    }
}

extension SettingsView {
    
    private var changeCurrencyButtonView: some View {
        NavigationLink {
            ChangeCurrencyView()
        } label: {
            HStack {
                Text("Change Currency")
                Spacer()
                CircleButton(buttonName: "arrow.forward.circle")
            }
            .padding(.horizontal)
            .withDefaultButtonFormatting(backgroundColor: Color.theme.reversed, foregroundColor: Color.primary)
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
                
                HStack {
                    Button {
                        vm.selectedTheme = 3
                    } label: {
                        BackgroundGradient(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color("PrimaryGradient"))
                            .cornerRadius(10)
                            .frame(width: 100, height: 100)
                            .scaleEffect((vm.selectedTheme == 3) ? 0.9 : 1)
                    }
                    .buttonStyle(.plain)

                    Button {
                        vm.selectedTheme = 1
                    } label: {
                        BottomGradientBackground(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color("PrimaryGradient"))
                            .cornerRadius(10)
                            .frame(width: 100, height: 100)
                            .scaleEffect((vm.selectedTheme == 1) ? 0.9 : 1)
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        vm.selectedTheme = 2
                    } label: {
                        AngularGradientBackground(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color("PrimaryGradient"))
                            .cornerRadius(10)
                            .frame(width: 100, height: 100)
                            .scaleEffect((vm.selectedTheme == 2) ? 0.9 : 1)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
            }
            .frame(height: 130)
            
            VStack {
                Text("Select background theme you will be using in goalie app.")
            }
            .padding()
            .foregroundColor(Color.primary.opacity(0.5))
            .withDataPresentationFieldStyle()
        }
    }
}

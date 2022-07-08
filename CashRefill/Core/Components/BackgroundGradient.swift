//
//  BackgroundGradient.swift
//  CashRefill
//
//  Created by Woturios on 31/05/2022.
//

import SwiftUI

struct BackgroundGradient: View {
    
    var primaryGradientColor: Color
    var secondaryGradientColor: Color
    
    var body: some View {
        RadialGradient(colors: [primaryGradientColor, secondaryGradientColor], center: .topLeading, startRadius: 0, endRadius: 300).ignoresSafeArea()
    }
}

struct AngularGradientBackground: View {
    
    var primaryGradientColor: Color
    var secondaryGradientColor: Color
    
    var body: some View {
        AngularGradient(colors: [primaryGradientColor, secondaryGradientColor], center: .topLeading, angle: .degrees(95)).ignoresSafeArea()
    }
}

struct BottomGradientBackground: View {
    
    var primaryGradientColor: Color
    var secondaryGradientColor: Color

    var body: some View {
        RadialGradient(colors: [primaryGradientColor.opacity(0.5), secondaryGradientColor], center: .bottom, startRadius: 0, endRadius: 500).ignoresSafeArea()
    }
}

struct GetBackgroundTheme: View {
    
    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {
        if vm.selectedTheme == 3 {
            BackgroundGradient(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color.theme.reversed)
        } else if vm.selectedTheme == 2 {
            AngularGradientBackground(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color.theme.reversed)
        } else if vm.selectedTheme == 1 {
            BottomGradientBackground(primaryGradientColor: vm.getAccentColor(), secondaryGradientColor: Color.theme.reversed)
        } else if vm.selectedTheme == 4 {
            EmptyView()
        }
    }
}

struct BackgroundGradient_Previews: PreviewProvider {
    static var previews: some View {
        AngularGradientBackground(primaryGradientColor: .blue, secondaryGradientColor: .black)
    }
}

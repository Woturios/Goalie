//
//  Color.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 20/05/2022.
//

import Foundation
import SwiftUI

extension Color {
    
//    static let theme = ColorTheme()
//    static let theme = GradientBackgroundTheme()
    static let theme = SubtleTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let reversed = Color("ReversedPrimary")
    let secondaryText = Color("SecondaryTextColor")
    let textFieldColor = Color("TextFieldColor")
    let firstTabBg = Color.blue
    let firstTabContent = Color.white
    let secondTabBg = Color.orange
    let secondTabContent = Color.black
    let thirdTabBg = Color.green
    let thirdTabContent = Color.white
}


struct GradientBackgroundTheme {
    
    let accent = Color("GradientAccent")
    let background = RadialGradient(colors: [Color("SecondaryGradient").opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500)
    let reversed = Color("ReversedPrimary")
    let secondaryText = Color.primary
    let textFieldColor = Color("TextFieldColor")
    let firstTabBg = Color.blue
    let firstTabContent = Color.white
    let secondTabBg = Color.orange
    let secondTabContent = Color.black
    let thirdTabBg = Color.green
    let thirdTabContent = Color.white
    
}


struct SubtleTheme {
    
    let accent = Color("SubtleGradient")
    let background = RadialGradient(colors: [Color("SubtleGradient").opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500)
    let reversed = Color("BackgroundColor")
    let secondaryText = Color.primary
    let textFieldColor = Color("TextFieldColor")
    let firstTabBg = Color("SubtleGradient")
    let firstTabContent = Color("BackgroundColor")
    let secondTabBg = Color("SecondTabSubtle")
    let secondTabContent = Color("BackgroundColor")
    let thirdTabBg = Color("ThirdTabSubtle")
    let thirdTabContent = Color("BackgroundColor")
}


//
//  Color.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 20/05/2022.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = GradientBackgroundTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let reversed = Color("ReversedPrimary")
    let secondaryText = Color("SecondaryTextColor")
    let textFieldColor = Color("TextFieldColor")
    
}


struct GradientBackgroundTheme {
    
    let accent = Color("AccentColor")
    let background = RadialGradient(colors: [Color("SecondaryGradient").opacity(0.5), Color("PrimaryGradient")], center: .bottom, startRadius: 0, endRadius: 500)
    let reversed = Color("ReversedPrimary")
    let secondaryText = Color("SecondaryTextColor")
    let textFieldColor = Color("TextFieldColor")
    
}


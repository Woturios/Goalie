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



struct GradientBackgroundTheme {
    
    let button = Color("GradientAccent")
    let accent = Color.primary
    let reversed = Color("ReversedPrimary")
    let textFieldColor = Color("TextFieldColor")
    let secondary = Color("SecondaryTextColor")
    let firstTabBg = Color.blue.opacity(0.5)
    let firstTabContent = Color.white
    let secondTabBg = Color.red.opacity(0.5)
    let secondTabContent = Color.black
    let thirdTabBg = Color.green.opacity(0.5)
    let thirdTabContent = Color.white
    
    
}


//
//  Color.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 20/05/2022.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let reversed = Color("ReversedPrimary")
    let secondaryText = Color("SecondaryTextColor")
    let textFieldColor = Color("TextFieldColor")
    
}


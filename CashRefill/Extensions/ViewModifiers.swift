//
//  ViewModifiers.swift
//  CashRefill
//
//  Created by Woturios on 30/05/2022.
//

import SwiftUI

extension View {
    
    func withDefaultButtonFormatting(backgroundColor: Color = .blue, foregroundColor: Color = .white) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
    
}


extension View {
    
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAdount: scaledAmount))
    }
}

//
//  ViewModifiers.swift
//  CashRefill
//
//  Created by Woturios on 30/05/2022.
//

import SwiftUI

extension View {
    
    /// Default aproving button formating
    func withDefaultButtonFormatting(backgroundColor: Color = .blue, foregroundColor: Color = .white) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor))
    }
    
    func withClearButton(text: Binding<String>) -> some View {
        modifier(ClearButton(text: text))
    }
    
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAdount: scaledAmount))
    }
    
    func withDefaultTextFieldFormatting() -> some View {
        modifier(DefaultTextFieldModifier())
    }
    
    func withDataPresentationFieldStyle() -> some View {
        modifier(DataPresentationFieldModifier())
    }
    
}

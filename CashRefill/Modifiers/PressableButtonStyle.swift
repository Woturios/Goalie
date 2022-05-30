//
//  PressableButtonStyle.swift
//  CashRefill
//
//  Created by Woturios on 30/05/2022.
//

import SwiftUI

/// Adds pressing animation to button
struct PressableButtonStyle: ButtonStyle {
    
    let scaledAmount: CGFloat
    
    init(scaledAdount: CGFloat) {
        self.scaledAmount = scaledAdount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

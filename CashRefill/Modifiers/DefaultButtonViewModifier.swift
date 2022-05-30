//
//  ButtonModifier.swift
//  CashRefill
//
//  Created by Woturios on 30/05/2022.
//

import SwiftUI

/// Default Approving button
struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    let foregroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(foregroundColor)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}


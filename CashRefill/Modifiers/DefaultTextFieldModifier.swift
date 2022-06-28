//
//  DefaultTextFieldModifier.swift
//  CashRefill
//
//  Created by Woturios on 30/05/2022.
//

import SwiftUI

struct DefaultTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(.leading)
            .frame(height: 55)
            .background(Color.theme.textFieldColor)
            .cornerRadius(10)
    }
}


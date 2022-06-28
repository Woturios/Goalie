//
//  DataPresentationFieldModifier.swift
//  CashRefill
//
//  Created by Woturios on 28/06/2022.
//

import SwiftUI

struct DataPresentationFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}

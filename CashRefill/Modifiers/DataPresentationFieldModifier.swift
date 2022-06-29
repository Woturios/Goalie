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
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}

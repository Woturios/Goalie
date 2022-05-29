//
//  ClearButton.swift
//  CashRefill
//
//  Created by Woturios on 29/05/2022.
//

import SwiftUI

// Soure: https://stackoverflow.com/a/58896723/18373625
struct ClearButton: ViewModifier
{
    @Binding var text: String

    public func body(content: Content) -> some View
    {
        HStack()
        {
            content

            if !text.isEmpty
            {
                Button(action:
                {
                    self.text = ""
                })
                {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
    }
}

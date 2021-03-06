//
//  CircleButton.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import SwiftUI

struct CircleButton: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    let buttonName: String
    
    // MARK: BODY
    var body: some View {
        Image(systemName: buttonName)
            .font(.title2)
            .foregroundColor(Color.theme.accent)
            .frame(height: 50)
    }
}

// MARK: PREVIEWS
struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(buttonName: "plus.circle.fill")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
            .padding()
        
        CircleButton(buttonName: "arrowshape.turn.up.backward.circle.fill")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .padding()
    }
}

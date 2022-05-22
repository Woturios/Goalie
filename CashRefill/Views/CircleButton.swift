//
//  CircleButton.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import SwiftUI

struct CircleButton: View {
    
    let buttonName: String
    
    var body: some View {
        Image(systemName: buttonName)
            .font(.title)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
    }
}

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

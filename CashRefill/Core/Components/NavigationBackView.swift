//
//  NavigationBackView.swift
//  CashRefill
//
//  Created by Woturios on 27/05/2022.
//

import SwiftUI

struct NavigationBackView: View {
    // MARK: BODY
    var body: some View {
        HStack {
            CircleButton(buttonName: "arrow.backward.circle")
            Text("Back")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.accent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 25)
    }
}

// MARK: PREVIEWS
struct NavigationBackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBackView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
        
        NavigationBackView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}

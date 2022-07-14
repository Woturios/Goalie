//
//  progressBarView.swift
//  CashRefill
//
//  Created by Woturios on 14/07/2022.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.teal)
                
                Rectangle()
                    .frame(
                        width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width),
                        height: geometry.size.height)
                    .foregroundColor(Color.blue)
                    .animation(.linear, value: value)
            }
            .cornerRadius(10)
        }
    }
}

struct progressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    @State var progressValue: Float = 0
    
    var body: some View {
        VStack {
            ProgressBar(value: $progressValue).frame(height: 20)
            Spacer()
        }.padding()
    }
}

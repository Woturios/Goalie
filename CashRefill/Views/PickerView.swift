//
//  PickerView.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 20/05/2022.
//

import SwiftUI

struct PickerView: View {
    @State var selection: String = "500"
    let filterOptions: [String] = [
        "500", "1000", "2000", "3000", "5000"
    ]
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor)
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some View {
        Picker(selection: $selection) {
            ForEach(filterOptions.indices) { index in
                Text(filterOptions[index])
                    .tag(filterOptions[index])
            }
        } label: {
            Text("Picker")
        }
        .pickerStyle(.segmented)
//        .background(Color.mint)
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}




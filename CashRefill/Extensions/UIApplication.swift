//
//  UIApplication.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 19/05/2022.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEdditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

//
//  UINavigationController.swift
//  CashRefill
//
//  Created by Woturios on 27/05/2022.
//

import Foundation
import SwiftUI

// Source: https://stackoverflow.com/a/68650943/18373625

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

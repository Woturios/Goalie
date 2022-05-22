//
//  CashRefillApp.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 18/05/2022.
//

import SwiftUI

@main
struct CashRefillApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
//                ZStack {
                    // Background layer
//                    Color.theme.background.ignoresSafeArea()
                    
                    // Content layer
                    HomeView()
//                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(vm)
        }
    }
}

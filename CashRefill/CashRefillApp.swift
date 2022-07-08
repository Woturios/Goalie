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
            TabBarView()
//            NavigationView {
//                    HomeView()
//            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(vm)
        }
    }
}

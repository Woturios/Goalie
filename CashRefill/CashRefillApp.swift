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
                .preferredColorScheme(
                    vm.preferedColorMode == 0 ? .light :
                        vm.preferedColorMode == 1 ? .dark :
                        nil)
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(vm)
        }
    }
}

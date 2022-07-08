//
//  TabBarView.swift
//  CashRefill
//
//  Created by Woturios on 06/07/2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
//            NavigationView {
//                GoalsView()
//            }
//            .tabItem {
//                Image(systemName: "target")
//                Text("Goals")
//            }
            
            NavigationView {
                SettingsView()
            }
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(HomeViewModel())
    }
}

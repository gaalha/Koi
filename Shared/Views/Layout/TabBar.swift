//
//  TabBar.swift
//  Koi (iOS)
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct TabBar: View {
    
    var body: some View {
        TabView {
            NavigationView {
                LibraryView()
            }
            .tabItem {
                Image(systemName: "book.closed")
                Text("Library")
            }
                
            NavigationView {
                HistoryView()
            }
            .tabItem {
                Image(systemName: "clock")
                Text("History")
            }
                
            NavigationView {
                ExploreView()
            }
            .tabItem {
                Image(systemName: "safari")
                Text("Explore")
            }
                
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "puzzlepiece.extension")
                Text("Extensions")
            }
                
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

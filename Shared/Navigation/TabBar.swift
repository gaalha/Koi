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
                MoreView()
            }
            .tabItem {
                Image(systemName: "ellipsis.circle")
                Text("More")
            }
            
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

//
//  Sidebar.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct Sidebar: View {
    
    var body: some View {
        NavigationView {
            #if os(iOS)
            content
                .navigationTitle("Koi")
            #else
            content
                .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
            #endif
            
            LibraryView()
        }
    }
    var content: some View {
        List {
            NavigationLink(destination: LibraryView()) {
                Label("Library", systemImage: "book.closed")
            }
            NavigationLink(destination: HistoryView()) {
                Label("History", systemImage: "clock")
            }
            NavigationLink(destination: ExploreView()) {
                Label("Explore", systemImage: "safari")
            }
            NavigationLink(destination: SettingsView()) {
                Label("Settings", systemImage: "gear")
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}

//
//  ContentView.swift
//  Shared
//
//  Created by Edgar Mejía on 20/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            TabBar()
        } else {
            Sidebar()
        }
        #else
        Sidebar()
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

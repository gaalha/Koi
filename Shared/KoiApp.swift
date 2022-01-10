//
//  KoiApp.swift
//  Shared
//
//  Created by Edgar Mejía on 20/6/21.
//

import SwiftUI

@main
struct KoiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}

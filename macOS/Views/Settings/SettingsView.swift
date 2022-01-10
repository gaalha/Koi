//
//  SettingsView.swift
//  Koi (macOS)
//
//  Created by Edgar Mejía on 9/1/22.
//


#if os(macOS)
import Foundation
import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
//            AdvancedSettingsView()
            Text("Hola")
                .tabItem {
                    Label("Advanced", systemImage: "star")
                }
                .tag(Tabs.advanced)
        }
        .padding(20)
        .frame(width: 375, height: 150)
    }
}
#endif

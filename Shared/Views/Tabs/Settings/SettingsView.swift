//
//  MoreView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI
import Foundation

struct SettingsView: View {
    
    var body: some View {
        Form {
            Section(header: Text("Tachidesk settings")) {
                NavigationLink(destination: TachideskOptionsView()) {
                    HStack {
                        Text("Set URL")
                        Spacer()
                        Text(Tachidesk().getFullHost())
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Section(header: Text("Trackers")) {
                Text("MyAnimeList")
                Text("AniList")
            }
            
            Section(header: Text("Library")) {
                Text("Actualization frecuence")
                Text("Edit categories")
                Text("Default category")
            }
            
            Section(header: Text("Reader")) {
                Text("Default reader mode")
                Text("Background color")
                
                Toggle(isOn: .constant(true), label: {
                    Text("Tap screen")
                })
                
                Toggle(isOn: .constant(true), label: {
                    Text("Volumen keys")
                })
            }
            
            Section(header: Text("Information"), footer: Text("v0.0.1")) {
                Text("Changelog")
                Text("Discord")
                Text("Support on Patreon")
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

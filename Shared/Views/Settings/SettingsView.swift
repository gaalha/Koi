//
//  MoreView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI
import Foundation

struct SettingsView: View {
    
    @AppStorage("HIDE_NSFW") var hideNsfw = false
    
    var body: some View {
        Form {
            Section(header: Text("Tachidesk")) {
                NavigationLink(destination: TachideskOptionsView()) {
                    HStack {
                        Text("Server Address")
                        Spacer()
                        Text(Tachidesk().getFullHost())
                            .foregroundColor(.gray)
                    }
                }
                
                NavigationLink(destination: TachideskAboutView()) {
                    Text("About Tachidesk")
                }
            }
            
            Section(header: Text("Trackers")) {
                Text("MyAnimeList")
                Text("AniList")
            }
            
            Section(header: Text("Library")) {
                Text("Actualization frecuence")
                Text("Categories")
//                Text("Default category")
                Toggle(isOn: $hideNsfw, label: {
                    Text("Hide NSFW content")
                })
            }
            
            Section(header: Text("Reader")) {
                HStack {
                    Text("Default mode")
                    Spacer()
                    Text("Horizontal")
                        .foregroundColor(.gray)
                }
                Text("Background color")
                
//                Toggle(isOn: .constant(true), label: {
//                    Text("Tap screen")
//                })
//
//                Toggle(isOn: .constant(true), label: {
//                    Text("Volumen keys")
//                })
            }
            
            Section(header: Text("About Tachiyomi")) {
                Link("Github", destination: URL(string: "https://github.com/edgarMejia/Koi")!)
                Link("Discord", destination: URL(string: "https://github.com/edgarMejia/Koi")!)
            }
            
            Section(header: Text("About Koi"), footer: Text("v0.0.1")) {
                Text("Changelog")
                Link("Github", destination: URL(string: "https://github.com/edgarMejia/Koi")!)
                Link("Support on Patreon", destination: URL(string: "https://www.patreon.com/EMMejia")!)
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

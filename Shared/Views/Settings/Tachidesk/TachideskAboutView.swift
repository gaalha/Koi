//
//  TachideskAboutView.swift
//  Koi
//
//  Created by Edgar Mejía on 26/12/21.
//

import SwiftUI

struct TachideskAboutView: View {
    
    @State var about: About = About()
    
    @State var isAboutLoaded: Bool = false
    
    @State var isError: Bool = false
    
    var body: some View {
        #if os(macOS)
        content
            .onAppear {
                fetchAbout()
            }
        #else
        content
            .onAppear {
                fetchAbout()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("About Tachideks")
        #endif
    }
    
    var content: some View {
        VStack {
            if !isAboutLoaded {
                VStack(alignment: .leading) {
                    ProgressView()
                        .padding(.top)
                }
            } else {
                if !isError {
                    Form {
                        Section(header: Text("General")) {
                            HStack {
                                Text("Server")
                                Spacer()
                                Text("\(about.name ?? "") \(about.buildType)")
                                    .foregroundColor(.gray)
                            }
                            
                            HStack {
                                Text("Server version")
                                Spacer()
                                Text("\(about.version)")
                                    .foregroundColor(.gray)
                            }
                            
    //                        HStack {
    //                            Text("Build time")
    //                            Spacer()
    //                            Text("\(self.about.name) \(self.about.buildType)")
    //                                .foregroundColor(.gray)
    //                        }
                        }
                        
                        Section(header: Text("Links")) {
                            Link("Github", destination: URL(string: self.about.github)!)
                            Link("Discord", destination: URL(string: self.about.discord)!)
                        }
                    }
                } else {
                    Text("Nothing to show 🥲")
                        .padding(.top)
                    HStack {
                        Button("Retry to load", action: fetchAbout)
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    
    func fetchAbout() {
        SettingViewModel().getAbout { response in
            switch response {
            case let .success(data):
                self.isAboutLoaded = true
                if data != nil { self.about = data! }
                else { self.isError = true }
            case let .failure(error):
                print(error)
                self.isAboutLoaded = true
                self.isError = true
            }
        }
    }
    
}

struct TachideskAboutView_Previews: PreviewProvider {
    static var previews: some View {
        TachideskAboutView()
    }
}

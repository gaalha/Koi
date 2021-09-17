//
//  LibraryView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct LibraryView: View {
    
    @State private var favoriteColor = "Red"
    
    var colors = ["Reading", "Planned", "NSFW"]
    
    var body: some View {
        content
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: 0) {
                Picker("", selection: $favoriteColor) {
                    ForEach(colors, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                MangaGrid()
                    .padding()
            }
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Picker("", selection: $favoriteColor) {
//                        ForEach(colors, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                }
//            }
            .navigationTitle("Library")
        }
    }
}


struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

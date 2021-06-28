//
//  LibraryView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct LibraryView: View {
    
    var body: some View {
        content
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: 0) {
                MangaGrid()
                    .padding()
            }
            .navigationTitle("Library")
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

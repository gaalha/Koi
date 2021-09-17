//
//  MangaGrid.swift
//  Koi
//
//  Created by Edgar Mejía on 27/6/21.
//

import SwiftUI

struct MangaGrid: View {
    
    var body: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 150, maximum: 160), spacing: 16)],
            spacing: 18
        ) {
            ForEach(recentManga, id: \.id) { manga in
                VStack {
                    #if os(iOS)
                    NavigationLink(destination: MangaDetialView(manga: manga)) {
                        MangaItem(manga: manga)
                            .frame(height: 220)
                    }
                    #else
                    // TODO: present modal logic
                    MangaItem(manga: manga)
                        .frame(height: 240)
                    #endif
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
}

struct MangaGrid_Previews: PreviewProvider {
    static var previews: some View {
        MangaGrid()
    }
}

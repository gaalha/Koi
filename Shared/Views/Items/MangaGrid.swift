//
//  MangaGrid.swift
//  Koi
//
//  Created by Edgar Mejía on 27/6/21.
//

import SwiftUI

struct MangaGrid: View {
    
    var mangaList: [Manga]
    
    var body: some View {
        if !mangaList.isEmpty {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 100, maximum: 110), spacing: 10)],
                spacing: 5
            ) {
                ForEach(mangaList, id: \.id) { manga in
                    VStack {
                        #if os(iOS)
                        NavigationLink(destination: MangaDetialView(manga: manga)) {
                            MangaItem(manga: manga)
                                .frame(height: 200)
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
    
}

struct MangaGrid_Previews: PreviewProvider {
    static var previews: some View {
        MangaGrid(mangaList: recentManga)
    }
}

//
//  MangaGrid.swift
//  Koi
//
//  Created by Edgar Mejía on 27/6/21.
//

import SwiftUI

struct MangaGrid: View {
    
    var mangaList: [Manga]
    
    @State var selectedManga: Manga?
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    var body: some View {
        if !self.mangaList.isEmpty {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 100, maximum: 110), spacing: 10)],
                spacing: 5
            ) {
                ForEach(self.mangaList) { manga in
                    #if os(iOS)
                    if horizontalSizeClass == .compact {
                        getMangaItem(manga: manga)
                            .onTapGesture {
                                self.selectedManga = manga
                            }
                            .fullScreenCover(item: $selectedManga) { presentedItem in
                                DetailView(manga: presentedItem)
                            }
                    } else {
                        getMangaItem(manga: manga)
                            .onTapGesture {
                                self.selectedManga = manga
                            }
                            .sheet(item: $selectedManga) { presentedItem in
                                DetailView(manga: presentedItem)
                            }
                    }
                    #else
                    // macOS ...
                    MangaItem(manga: manga)
                        .frame(height: 240)
                    #endif
                }
            }
        } else {
            EmptyView()
        }
    }
    
    func getMangaItem(manga: Manga) -> some View {
        MangaItem(manga: manga)
            .frame(height: 200)
    }
}

//struct MangaGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        MangaGrid(mangaList: recentManga)
//    }
//}

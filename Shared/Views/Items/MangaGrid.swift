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
    
    @AppStorage("HIDE_NSFW") var hideNsfw = false
    
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
                    if !hideNsfw {
                        self.getGridItem(manga: manga)
                    } else if hideNsfw {
                        if manga.source == nil || !(manga.source?.isNsfw ?? true) {
                            self.getGridItem(manga: manga)
                        }
//                        else if manga.source == nil { self.getGridItem(manga: manga) }
                    }
                }
            }
            Text("Total: \(self.mangaList.count)")
                .font(.footnote)
                .foregroundColor(.gray)
        } else {
            EmptyView()
        }
    }
    
    func getGridItem(manga: Manga) -> some View {
        VStack {
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

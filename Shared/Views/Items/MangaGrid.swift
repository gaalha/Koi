//
//  MangaGrid.swift
//  Koi
//
//  Created by Edgar Mejía on 27/6/21.
//

import SwiftUI

struct MangaGrid: View {
    
    var mangaList: [Manga]
    
    @State private var showDetail = false
    
    @State private var selectedManga: Manga? = nil
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    
    var body: some View {
        if !mangaList.isEmpty {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 100, maximum: 110), spacing: 10)],
                spacing: 5
            ) {
                ForEach(mangaList, id: \.id) { mangaSelected in
                    VStack {
                        #if os(iOS)
                        if horizontalSizeClass == .compact {
                            MangaItem(manga: mangaSelected)
                                .frame(height: 200)
                                .fullScreenCover(isPresented: self.$showDetail) {
                                    DetailView(manga: mangaSelected)
                                }
                                .onTapGesture {
                                    showDetail.toggle()
                                }
                        } else {
                            MangaItem(manga: mangaSelected)
                                .frame(height: 200)
                                .sheet(isPresented: $showDetail) {
                                    DetailView(manga: mangaSelected)
                                }
                                .onTapGesture {
                                    print("\(mangaSelected.title!)")
                                    showDetail.toggle()
                                }
                        }
                        #else
                        // macOS ...
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

//struct MangaGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        MangaGrid(mangaList: recentManga)
//    }
//}

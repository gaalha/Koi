//
//  MangaDetialView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI
#if os(iOS)
import Introspect
#endif

struct MangaDetialView: View {
    
    var manga: Manga
    
    #if os(iOS)
    @State var uiTabarController: UITabBarController?
    #endif
    
    @State var chapters: [Chapter] = []
    
    @State var chaptersLoaded: Bool = false
    
    var body: some View {
        #if os(iOS)
        content
            .edgesIgnoringSafeArea(.all)
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
                uiTabarController = UITabBarController
            }
            .onAppear {
                fetchChapterList(mangaId: manga.id)
            }
            .onDisappear {
                uiTabarController?.tabBar.isHidden = false
            }
        #else
        content
            .onAppear {
                fetchChapterList(mangaId: manga.id)
            }
        #endif
    }
    
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottom) {
                    thumbnail
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 320, alignment: .topLeading)
                        .blur(radius: 8)
                        .clipped()
                    
                    DescriptionGradient()
                    
                    mangaCover
                        .padding()
                }
            }
            .foregroundColor(.white)
            .cornerRadius(20)
            
            mangaList
                .padding()
        }
    }
    
    var mangaCover: some View {
        HStack {
            thumbnail
                .frame(width: 105, height: 150, alignment: .leading)
                .scaledToFill()
                .shadow(radius: 10)
            
            VStack(alignment: .leading) {
                MangaDescription(title: manga.title, description: manga.description, author: manga.author)
                
                MangaDetailActions()
            }
        }
    }
    
    var mangaList: some View {
        VStack {
            if self.chaptersLoaded && !self.chapters.isEmpty {
                ForEach(chapters, id: \.id) { chapter in
                    ChapterListItem(chapter: chapter)
                    Divider()
                }
            } else if self.chaptersLoaded && self.chapters.isEmpty {
                Text("No chapters found 🥲")
            } else if !chaptersLoaded {
                ProgressView()
            }
        }
    }
    
    var thumbnail: some View {
        AsyncImage(
            url: URL(string: "\(Constants.TACHIDESK_HOST)/api/v1/manga/\(manga.id)/thumbnail")!,
            image: {
                Image(uiImage: $0)
                    .resizable()
            }
        )
    }
    
    func fetchChapterList(mangaId: Int) {
        MangaViewModel().getChapters(mangaId: mangaId) { chapters in
            chaptersLoaded = true
            self.chapters = chapters
        }
    }
    
}

struct MangaDetialView_Previews: PreviewProvider {
    static var previews: some View {
        MangaDetialView(manga: Manga(id: 2, title: "Berserk", description: "Berserk es un manga creado por Kentaro Miura y posteriormente adaptado en anime, con un estilo épico fantástico y de fantasía oscura. Miura publicó un prototipo de Berserk en 1988.", author: "Kentaro Miura", url: "#", thumbnailUrl: "https://uploads.mangadex.org/covers/06cdf186-6bba-4ba2-a68d-2093e1d3b35f/64ff735c-6f6a-4dae-9b1c-9b6be43649c0.jpg"))
    }
}

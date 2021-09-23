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
                .background(Color("ImagePlaceholder"))
                .scaledToFill()
                .shadow(radius: 10)
                .cornerRadius(5)
            
            VStack(alignment: .leading) {
                MangaDescription(manga: self.manga)
                MangaDetailActions()
            }
        }
    }
    
    var mangaList: some View {
        LazyVStack {
            if self.chaptersLoaded && !self.chapters.isEmpty {
                ForEach(chapters, id: \.id) { chapter in
                    #if os(iOS)
                    NavigationLink(destination: ReaderView(chapter: chapter)) {
                        ChapterListItem(chapter: chapter)
                    }
                    Divider()
                    #endif
                }
            } else if self.chaptersLoaded && self.chapters.isEmpty {
                Text("No chapters found 🥲")
            } else if !chaptersLoaded {
                ProgressView()
            }
        }
    }
    
    var thumbnail: some View {
        CacheAsyncImage(
            url: URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(manga.id)/thumbnail")!
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
            case .failure(_):
                Image(systemName: "xmark.octagon.fill")
            @unknown default:
                EmptyView()
            }
        }
    }
    
    func fetchChapterList(mangaId: Int) {
        MangaViewModel().getChapters(mangaId: mangaId) { result in
            switch result {
            case let .success(chapters):
                self.chaptersLoaded = true
                if chapters != nil {
                    self.chapters = chapters!
                }
                
            case let .failure(error):
                print(error)
                self.chaptersLoaded = true
            }
        }
    }
    
}

struct MangaDetialView_Previews: PreviewProvider {
    static var previews: some View {
        MangaDetialView(manga: Manga(id: 2, title: "Berserk", description: "Berserk es un manga creado por Kentaro Miura y posteriormente adaptado en anime, con un estilo épico fantástico y de fantasía oscura. Miura publicó un prototipo de Berserk en 1988.", author: "Kentaro Miura", url: "#", thumbnailUrl: "https://uploads.mangadex.org/covers/06cdf186-6bba-4ba2-a68d-2093e1d3b35f/64ff735c-6f6a-4dae-9b1c-9b6be43649c0.jpg"))
    }
}

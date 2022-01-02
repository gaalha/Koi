//
//  DetailView.swift
//  Koi
//
//  Created by Edgar Mejía on 24/9/21.
//

import SwiftUI
import CachedAsyncImage

struct DetailView: View {
    
    var manga: Manga
    
    @StateObject private var mangaViewModel = MangaViewModel()
    
    @State var chaptersLoaded: Bool = false
    
    @State var hasError: Bool = false
    
    @State var offset: CGFloat = 0
    
    @State var showReader = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        content
            .overlay(closeButton, alignment: .topTrailing)
            .ignoresSafeArea(.container, edges: .top)
            .onAppear {
                self.fetchChapterList(mangaId: self.manga.id)
            }
    }
    
    var content: some View {
        ZStack(alignment: .top) {
            ZStack {
                // Blur bg.
                thumbnail
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300, alignment: .bottom)
                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight], radius: getCornerRadius()))
                    .opacity(1 + getProgress())
                
                CustomCorner(corners: [.bottomLeft, .bottomRight], radius: getCornerRadius())
                    .fill(.ultraThinMaterial)
                
                mangaDescription
                .padding(15)
                .padding(.bottom, 30)
                .offset(y: calculateTitleAndThumbnailPosition() * -90)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            }
            .frame(height: 350)
            .offset(y: getOffset())
            .zIndex(1)
            
            ScrollView {
                chapterListContent
            }
        }
    }
    
    var closeButton: some View {
        Button(action: {
            self.dismiss()
        }, label: {CloseButton()}).padding(30)
    }
    
    var thumbnail: some View {
        CachedAsyncImage(
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
    
    var mangaDescription: some View {
        HStack(alignment: .top) {
            thumbnail
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 150)
                .cornerRadius(5)
                .scaleEffect(1 + calculateTitleAndThumbnailPosition() * 1.5, anchor: .bottomLeading)
                .offset(y: calculateTitleAndThumbnailPosition())

            VStack(alignment: .leading) {
                Text(manga.title)
                    .fontWeight(.bold)
                    .lineLimit(3)
                    .offset(x: calculateTitleAndThumbnailPosition() * 150, y: calculateTitleAndThumbnailPosition() * -270)
                Text(manga.description ?? "")
                    .lineLimit(4)
                    .opacity(1 + getProgress())
                Text(manga.author ?? "")
                    .fontWeight(.bold)
                    .opacity(1 + getProgress())
            }.padding(.leading)

            Spacer()
        }
    }
    
    var chapterListContent: some View {
        LazyVStack {
            if !chaptersLoaded {
                ProgressView()
            } else {
                if hasError {
                    Text("Something went wrong ... 🥲")
                        .padding(.top)
                    HStack {
                        Button("Retry to load", action: {
                            self.fetchChapterList(mangaId: self.manga.id)
                        })
                    }
                    .buttonStyle(.bordered)
                } else {
                    if self.mangaViewModel.chapterList.isEmpty {
                        Text("No chapters found 🥲")
                        Button("Retry to load", action: {
                            self.fetchChapterList(mangaId: self.manga.id)
                        })
                    } else {
                        ForEach(self.mangaViewModel.chapterList, id: \.id) { chapter in
                            self.chapterItem(chapter: chapter)
                            .fullScreenCover(isPresented: self.$showReader) {
                                ReaderViewPaginated(chapter: chapter)
                            }
                            .onTapGesture {
                                self.showReader = true
                            }
                            .padding(.leading)
                            .padding(.trailing)
                            Divider()
                        }
                    }
                }
            }
        }
        .modifier(OffsetModifier(offset: $offset))
        .padding(.top, 420)
        .padding(.top, -getSafeArea().top)
    }
    
    func chapterItem(chapter: Chapter!) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(chapter.name)
                Text(chapter.scanlator ?? "")
            }
            Spacer()
            DownloadButton(chapter: chapter)
        }
    }
    
    func getOffset() -> CGFloat {
        let checkSize = -offset < (280-getSafeArea().top) ? offset : -(280-getSafeArea().top)
        return offset < 0 ? checkSize : 0
    }
    
    func getProgress() -> CGFloat {
        let topHeight = (280-getSafeArea().top)
        let progress = getOffset() / topHeight
        return progress
    }
    
    func getCornerRadius() -> CGFloat {
        let radius = getProgress() * 45
        
        return 45 + radius
    }
    
    func calculateTitleAndThumbnailPosition() -> CGFloat  {
        let progress = -getProgress() < 0.4 ? getProgress() : -0.4
        return progress
    }
    
    func fetchChapterList(mangaId: Int) {
        self.mangaViewModel.getChapters(mangaId: mangaId) { err in
            self.chaptersLoaded = true
            if let err = err {
                print(err)
                self.hasError = true
                return
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//            .previewDevice("iPhone 11 Pro")
//            .preferredColorScheme(.dark)
//    }
//}

extension View {
    
    func getScreenBound() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        let null = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return null }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets
        else { return null }
        
        return safeArea
    }
    
}

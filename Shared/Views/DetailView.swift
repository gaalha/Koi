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
    
    @State var chapters: [Chapter] = []
    
    @State var chaptersLoaded: Bool = false
    
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
                
//                HStack {
//                    Button(action: {
//                        print("Touched")
//                    }, label: {
//                        HStack {
//                            Image(systemName: "plus")
//                            Text("Library")
//                        }
//                    })
//                        .buttonStyle(.bordered)
//                        .background(.gray)
//                        .foregroundColor(.black)
//                        .cornerRadius(18)
//                        .opacity(1 + getProgress())
//
//                    Button(action: {
//                        print("Touched")
//                    }, label: {
//                        HStack {
//                            Image(systemName: "minus")
//                            Text("Library")
//                        }
//                    })
//                        .buttonStyle(.bordered)
//                        .background(.tint)
//                        .foregroundColor(.white)
//                        .cornerRadius(18)
//                        .opacity(1 + getProgress())
//                }
                
            }.padding(.leading)

            Spacer()
        }
    }
    
    var chapterListContent: some View {
        LazyVStack {
            if self.chaptersLoaded && !self.chapters.isEmpty {
                ForEach(chapters, id: \.id) { chapter in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(chapter.name)
                            Text(chapter.scanlator ?? "")
                        }
                        Spacer()
                        DownloadButton(chapter: chapter)
                    }
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
            } else if self.chaptersLoaded && self.chapters.isEmpty {
                Text("No chapters found 🥲")
            } else if !chaptersLoaded {
                ProgressView()
            }
        }
        .modifier(OffsetModifier(offset: $offset))
        .padding(.top, 420)
        .padding(.top, -getSafeArea().top)
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

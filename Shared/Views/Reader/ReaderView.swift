//
//  ReaderView.swift
//  Koi (iOS)
//
//  Created by Edgar Mejía on 23/8/21.
//

import SwiftUI
import CachedAsyncImage
#if os(iOS)
import Introspect
#endif

struct ReaderView: View {
    
    var chapter: Chapter
    
    @State var chapterDetail: Chapter? = nil
    
    @State var chapterDetailLoaded: Bool = false
    
    @State var hideNavigationBar: Bool = false
    
    @State var drag: CGFloat = 0.0
    
    #if os(iOS)
    @State var uiTabarController: UITabBarController?
    #endif
    
    var body: some View {
        content
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(chapter.name)
        .navigationBarHidden(hideNavigationBar)
        .onAppear {
            uiTabarController?.tabBar.isHidden = true
            self.loadChapterDetail()
        }
    }
    
    var content: some View {
        ScrollView {
            LazyVStack {
                if !chapterDetailLoaded {
                    ProgressView()
                } else if chapterDetailLoaded && chapterDetail != nil {
//                    LazyVStack {
                    ForEach(0..<self.chapterDetail!.pageCount!) { page in
                        loadImage(url: getPageUrl(chapter: chapter, page: page))
                    }
//                    }
    //                .onTapGesture {
    //                    self.hideNavigationBar.toggle()
    //                }
                } else {
                    Text("No pages found")
                }
            }
        }
    }
    
    private func loadImage(url: String) -> some View {
        CachedAsyncImage(
            url: URL(string: url)!
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
            case .failure:
                VStack {
                    Text(url)
                    Button("Retry", action: {
                        print("Reload")
                    })
                }
                    .buttonStyle(.bordered)
            @unknown default:
                EmptyView()
            }
        }
        .aspectRatio(contentMode: .fit)
        .frame(minHeight: 200.0)
    }
    
    private func loadChapterDetail() {
        if self.chapter.pageCount! == -1 {
            ChapterViewModel().getDetail(
                mangaId: self.chapter.mangaId,
                chapterIndex: self.chapter.index!,
                completion: { result in
                    
                switch result {
                case let .success(chapter):
                    self.chapterDetailLoaded = true
                    if chapter != nil {
                        self.chapterDetail = chapter!
                    }
                    
                case let .failure(error):
                    print(error)
                    self.chapterDetailLoaded = true
                }
            })
        } else {
            print("\(self.chapter.pageCount!)")
            self.chapterDetail = self.chapter
            self.chapterDetailLoaded = true
        }
    }
    
    private func retryToLoadImage(url: String) -> some View {
        return loadImage(url: url)
    }
    
    private func getPageUrl(chapter: Chapter, page: Int) -> String {
        print(page)
        let mangaId = "\(chapter.mangaId!)"
        let chapterNumber = "\(chapter.index!)"
        
        return "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(mangaId)/chapter/\(chapterNumber)/page/\(page)"
    }
}

//struct ReaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReaderView()
//    }
//}

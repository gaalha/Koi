//
//  ReaderViewPaginated.swift
//  Koi (iOS)
//
//  Created by Edgar Mejía on 24/9/21.
//

import SwiftUI

struct ReaderViewPaginated: View {
    
    var chapter: Chapter
    
    @State var chapterDetail: Chapter? = nil
    
    @State var chapterDetailLoaded: Bool = false
    
    @State var numberOfPages: Int = 0
    
    @State var currentPage: Int = 0
    
    @State var showOrientationIndicator: Bool = true
    
    @State var showReaderControllers: Bool = true
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        content
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .onAppear {
                self.loadChapterDetail()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showOrientationIndicator.toggle()
                    self.showReaderControllers = false
                }
            }
    }
    
    var content: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .overlay(closeButton, alignment: .topTrailing)
            
            if !self.chapterDetailLoaded {
                loadingPages
            } else if self.chapterDetailLoaded && self.chapterDetail != nil && self.numberOfPages>0 {
                readerContent
            } else {
                noPagesContent
            }
            
            if showOrientationIndicator {
                orientationIndicator
            }
        }
    }
    
    var loadingPages: some View {
        VStack {
            ProgressView()
            Text("Fetching pages")
        }
    }
    
    var noPagesContent: some View {
        Text("No pages found")
    }
    
    var readerContent: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<self.numberOfPages, id: \.self) { page in
                if currentPage == page {
                    loadImage(url: getPageUrl(chapter: self.chapterDetail!, page: page))
                } else {
                    ProgressView()
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(pageNumberIndicator, alignment: .bottom)
        .overlay(closeButton, alignment: .topTrailing)
    }
    
    var orientationIndicator: some View {
        AlertItem(icon: "rectangle.expand.vertical", message: "Horizontal pagination")
    }
    
    var pageNumberIndicator: some View {
        Text("\(self.currentPage + 1)/\(self.numberOfPages)")
            .font(.system(size: 15, weight: .bold))
            .shadow(color: .black, radius: 0.5)
            .padding(.bottom, 30)
            .foregroundColor(.white)
    }
    
    var closeButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {CloseButton()}).padding(30)
    }
    
    private func loadImage(url: String) -> some View {
        CacheAsyncImage(
            url: URL(string: url)!
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                ZoomableScrollView {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
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
                        self.numberOfPages = chapter!.pageCount ?? 0
                    }
                    
                case let .failure(error):
                    print(error)
                    self.chapterDetailLoaded = true
                }
            })
        } else {
            self.chapterDetail = self.chapter
            self.chapterDetailLoaded = true
            self.numberOfPages =  self.chapter.pageCount ?? 0
        }
    }
    
    private func getPageUrl(chapter: Chapter, page: Int) -> String {
        let mangaId = "\(chapter.mangaId!)"
        let chapterNumber = "\(chapter.index!)"
        
        return "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(mangaId)/chapter/\(chapterNumber)/page/\(page)"
    }
    
}

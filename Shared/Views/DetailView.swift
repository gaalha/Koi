//
//  DetailView.swift
//  Koi
//
//  Created by Edgar Mejía on 24/9/21.
//

import SwiftUI
import CachedAsyncImage
import ImageViewerRemote
import Introspect

struct DetailView: View {
    
    var manga: Manga
    
    @StateObject private var mangaViewModel = MangaViewModel()
    
    @State var chaptersLoaded: Bool = false
    
    @State var hasError: Bool = false
    
    @State var offset: CGFloat = 0
    
    @State var showReader = false
    
    @State var uiTabBarController: UITabBarController?
    
    @State var showThumbnailViewer: Bool = false
    
    @State var imgURL: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(ImageViewerRemote(imageURL: self.$imgURL, viewerShown: self.$showThumbnailViewer))
            .ignoresSafeArea(.container, edges: [.leading, .trailing])
            .navigationBarItems(trailing: {
                Menu {
                    Button(action: {
                        print("Add to library")
                    }) {
                        Label("Add to library", systemImage: "book")
                    }
                    
                    Button(action: {
                        print("Download")
                    }) {
                        Label("Download", systemImage: "arrow.down.circle")
                    }
                    
                    Button(action: {
                        shareURL(url: manga.realUrl!)
                    }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    
                    Button(action: {
                        self.openURL(URL(string: manga.realUrl!)!)
                    }) {
                        Label("Open URL", systemImage: "safari")
                    }
                    
                    Button(action: {
                        copyURL(url: manga.realUrl!)
                    }) {
                        Label("Copy URL", systemImage: "doc.on.clipboard")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }())
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
                uiTabBarController = UITabBarController
            }
            .onAppear {
                UITableView.appearance().separatorColor = .clear
                fetchChapterList(mangaId: manga.id)
            }
            .onDisappear {
                UITableView.appearance().separatorColor = .separator
                uiTabBarController?.tabBar.isHidden = false
            }
    }
    
    var content: some View {
        List {
            Section {
                detailSection
            }
            
            Text(getChaptersCount())
                .font(.caption)
                .foregroundColor(.gray)
            
            Section {
                if !chaptersLoaded {
                    ProgressView()
                } else {
                    if hasError {
                        Text("Something went wrong ... 🥲")
                            .padding(.top)
                        HStack {
                            Button("Retry to load", action: {
                                fetchChapterList(mangaId: manga.id)
                            })
                        }
                        .buttonStyle(.bordered)
                    } else {
                        if mangaViewModel.chapterList.isEmpty {
                            Text("No chapters found 🥲")
                            Button("Retry to load", action: {
                                fetchChapterList(mangaId: manga.id)
                            })
                        } else {
                            ForEach(mangaViewModel.chapterList, id: \.id) { chapter in
                                self.chapterItem(chapter: chapter)
                                    .contextMenu {
                                        Button(action: { self.copyURL(url: chapter.url!) }) { Label("Copy URL", systemImage: "doc.on.clipboard") }
                                        Button(action: { self.openURL(URL(string: chapter.url!)!) }) { Label("Open URL", systemImage: "safari") }
                                        
                                        if chapter.downloaded {
                                            Button(action: { }) { Label("Remove Download", systemImage: "checkmark.circle.fill") }
                                        } else {
                                            Button(action: { }) { Label("Download", systemImage: "arrow.down.circle") }
                                        }
                                        
                                        if chapter.bookmarked {
                                            Button(action: { }) { Label("Remove Bookmark", systemImage: "bookmark.slash") }
                                        } else {
                                            Button(action: { }) { Label("Add Bookmark", systemImage: "bookmark.fill") }
                                        }
                                        
                                        if chapter.read {
                                            Button(action: { }) { Label("Mark as unread", systemImage: "eye.slash") }
                                        } else {
                                            Button(action: { }) { Label("Mark as read", systemImage: "eye") }
                                        }
                                    }
                                    .onTapGesture {
                                        self.showReader = true
                                    }
                                    .fullScreenCover(isPresented: self.$showReader) {
                                        ReaderViewPaginated(chapter: chapter)
                                    }
                                    .swipeActions(edge: .leading) {
                                        if chapter.bookmarked {
                                            Button(action: { print("Remove Bookmark") }, label: { Image(systemName: "bookmark.slash") }).tint(.accentColor)
                                        } else {
                                            Button(action: { print("Bookmark") }, label: { Image(systemName: "bookmark") }).tint(.accentColor)
                                        }
                                    }
                                    .swipeActions(edge: .trailing) {
                                        if chapter.read {
                                            Button(action: { print("Remove read") }, label: { Image(systemName: "eye.slash") }).tint(.blue)
                                        } else {
                                            Button(action: { print("As read") }, label: { Image(systemName: "eye") }).tint(.blue)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
        .refreshable {
            fetchChapterList(mangaId: manga.id)
        }
        .listStyle(PlainListStyle())
    }
    
    var detailSection: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .top) {
                thumbnail
                    .onTapGesture {
                        self.imgURL = getThumbnailURL()
                        self.showThumbnailViewer.toggle()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                
                VStack(alignment: .leading) {
                    Text(manga.title)
                        .fontWeight(.bold)
                        .lineLimit(3)
                    Text(manga.author ?? "No author")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(manga.source?.name ?? "No source name")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(manga.description ?? "No description")
                        .font(.footnote)
                        .lineLimit(6)
                        .padding(.top)
                }
                .padding([.leading, .trailing])
            }
            
            if manga.genre != nil && !manga.genre!.isEmpty {
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(manga.genre!, id: \.self) { genre in
                            TagView(tag: genre)
                        }
                    }
                    .fixedSize(horizontal: true, vertical: true)
                }
            }
        }
    }
    
    var thumbnail: some View {
        CachedAsyncImage(
            url: URL(string: getThumbnailURL())!
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
    
    func chapterItem(chapter: Chapter!) -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    if chapter.bookmarked {
                        Image(systemName: "bookmark.fill")
                            .font(.footnote)
                            .foregroundColor(.accentColor)
                    }
                    
                    if chapter.read {
                        Text(chapter.name)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    } else {
                        Text(chapter.name)
                            .lineLimit(1)
                    }
                }
                
                Text(chapter.scanlator ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            if chapter.downloaded {
                Button(action: { print("Remove download") }, label: { Image(systemName: "checkmark.circle.fill") })
            } else {
                DownloadButton(chapter: chapter)
            }
        }
    }
    
    func fetchChapterList(mangaId: Int) {
        mangaViewModel.getChapters(mangaId: mangaId) { err in
            self.chaptersLoaded = true
            if let err = err {
                print(err)
                self.hasError = true
                return
            }
        }
    }
    
    func shareURL(url: String) {
        guard let data = URL(string: url) else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        DispatchQueue.main.async {
            window?.rootViewController?.present(av, animated: true, completion: nil)
        }
    }
    
    func copyURL(url: String) {
        UIPasteboard.general.string = url
    }
    
    func getChaptersCount() -> String {
        if mangaViewModel.chapterList.isEmpty {
            return ""
        } else if mangaViewModel.chapterList.count == 1 {
            return "\(mangaViewModel.chapterList.count) chapter".uppercased()
        } else {
            return "\(mangaViewModel.chapterList.count) chapters".uppercased()
        }
    }
    
    func getThumbnailURL() -> String {
        "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(manga.id)/thumbnail"
    }
    
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//            .previewDevice("iPhone 11 Pro")
//            .preferredColorScheme(.dark)
//    }
//}


//
//  ReaderView.swift
//  Koi (iOS)
//
//  Created by Edgar Mejía on 23/8/21.
//

import SwiftUI

struct ReaderView: View {
    
    var chapter: Chapter
    
    @State var hideNavigationBar: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<3) { page in
                    CacheAsyncImage(
                        url: URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/136/chapter/471/page/\(page)")!
                    ) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                        case .failure:
//                            Image(systemName: "xmark.octagon.fill")
                            Button("Retry", action: retryToLoadImage)
                                .buttonStyle(.bordered)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(minHeight: 200.0)
                }
            }
            .onTapGesture {
                self.hideNavigationBar.toggle()
            }
        }
//        .edgesIgnoringSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(chapter.name)
        .navigationBarHidden(hideNavigationBar)
    }
    
    private func retryToLoadImage() {
        print("Retry")
    }
}

//struct ReaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReaderView()
//    }
//}

//
//  ReaderView.swift
//  Koi (iOS)
//
//  Created by Edgar Mejía on 23/8/21.
//

import SwiftUI

struct ReaderView: View {
    
    var chapter: Chapter
    
    @State private var hideStatusBar = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<3) { page in
                    CustomAsyncImage(
                        url: URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/136/chapter/471/page/\(page)")!,
                        image: {
                            Image(uiImage: $0)
                                .resizable()
                        }
                    )
                    .aspectRatio(contentMode: .fit)
                    .frame(minHeight: 200.0)
                }
            }
        }
    }
}

//struct ReaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReaderView()
//    }
//}

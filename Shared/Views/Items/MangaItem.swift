//
//  MangaItem.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI
import Foundation

struct MangaItem: View {
    
    var manga: Manga
    
    var body: some View {
        
        let thumnailUrl = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(manga.id)/thumbnail")!
        
        VStack(alignment: .leading) {
            CacheAsyncImage(
                url: thumnailUrl,
                transaction: Transaction(animation: .easeInOut)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                case .failure:
                    Image(systemName: "xmark.octagon.fill")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.gray)
            .background(Color("ImagePlaceholder"))
            .cornerRadius(5)
            .shadow(radius: 1)
            
            Text(manga.title)
                .font(.system(size: 13))
                .foregroundColor(Color("Text"))
                .lineLimit(2)
                .frame(minHeight: 30, alignment: .top)
        }
    }
    
}

struct MangaItem_Previews: PreviewProvider {
    static var previews: some View {
        MangaItem(manga: Manga(id: 2, title: "", description: "", author: "", url: "", thumbnailUrl: "https://uploads.mangadex.org/covers/06cdf186-6bba-4ba2-a68d-2093e1d3b35f/64ff735c-6f6a-4dae-9b1c-9b6be43649c0.jpg"))
    }
}

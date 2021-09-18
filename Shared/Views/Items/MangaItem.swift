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
        
        let thumnailUrl = URL(string: "\(Constants.TACHIDESK_HOST)/api/v1/manga/\(manga.id)/thumbnail")!
        
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    DescriptionGradient()
                    VStack(alignment: .leading, spacing: 4) {
                        Spacer()
                        MangaDescription(title: "", author: "")
                    }
                }
            }
            .foregroundColor(.white)
            .background(
                AsyncImage(
                    url:  thumnailUrl,
                    image: {
                        Image(uiImage: $0)
                            .resizable()
                    }
                )
            )
            .cornerRadius(20)
            .shadow(radius: 1)
            
            Text(manga.title)
                .font(.body)
                .foregroundColor(Color("Text"))
                .lineLimit(2)
                .frame(minHeight: 40, alignment: .top)
        }
    }
    
}

struct MangaItem_Previews: PreviewProvider {
    static var previews: some View {
        MangaItem(manga: Manga(id: 2, title: "", description: "", author: "", url: "", thumbnailUrl: "https://uploads.mangadex.org/covers/06cdf186-6bba-4ba2-a68d-2093e1d3b35f/64ff735c-6f6a-4dae-9b1c-9b6be43649c0.jpg"))
    }
}

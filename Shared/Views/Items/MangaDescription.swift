//
//  MangaDescription.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct MangaDescription: View {
    
    var manga: Manga!
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(manga.title)
                    .fontWeight(.bold)
                    .lineLimit(3)
                if manga.description != nil {
                    Text(manga.description ?? "")
                        .lineLimit(3)
                }
                if manga.author != nil {
                    Text(manga.author ?? "")
                        .fontWeight(.bold)
                }
            }
            Spacer()
        }
    }
}

//struct MangaDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        MangaDescription()
//    }
//}

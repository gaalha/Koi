//
//  MangaItem.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct MangaItem: View {
    
    var manga: Manga
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                DescriptionGradient()
                VStack(alignment: .leading, spacing: 4) {
                    Spacer()
                    MangaDescription(title: manga.title, author: manga.author)
                        .padding()
                }
            }
        }
        .foregroundColor(.white)
        .background(
            Image(manga.coverUrl)
                .resizable()
                .scaledToFill()
                .frame(alignment: .topLeading)
        )
        .cornerRadius(20)
        .shadow(radius: 1)
    }
    
}

struct MangaItem_Previews: PreviewProvider {
    static var previews: some View {
        MangaItem(manga: Manga(id: 2, title: "Berserk", description: nil, author: "Kentaro Miura", url: "#", coverUrl: "03"))
    }
}

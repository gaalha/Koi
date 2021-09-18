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
                Image(manga.coverUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(alignment: .topLeading)
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
        MangaItem(manga: Manga(id: 2, title: "", description: "", author: "", url: "", coverUrl: "03"))
    }
}

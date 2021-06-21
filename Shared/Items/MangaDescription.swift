//
//  MangaDescription.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct MangaDescription: View {
    
    var title: String!
    
    var description: String?
    
    var author: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(2)
                .shadow(radius: 10)
            if description != nil {
                Text(description ?? "")
                    .lineLimit(3)
                    .shadow(radius: 5)
            }
            if author != nil {
                Text(author ?? "")
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                    .shadow(radius: 5)
            }
        }
        .padding()
    }
}

struct MangaDescription_Previews: PreviewProvider {
    static var previews: some View {
        MangaDescription(title: "Berserk", description: "Berserk es un manga creado por Kentaro Miura y posteriormente adaptado en anime, con un estilo épico fantástico y de fantasía oscura. Miura publicó un prototipo de Berserk en 1988.", author: "Kentaro Miura")
    }
}

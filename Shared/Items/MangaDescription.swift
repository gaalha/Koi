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
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.bold)
                    .lineLimit(3)
                if description != nil {
                    Text(description ?? "")
                        .lineLimit(3)
                }
                if author != nil {
                    Text(author ?? "")
                        .fontWeight(.bold)
                }
            }
            Spacer()
        }
    }
}

struct MangaDescription_Previews: PreviewProvider {
    static var previews: some View {
        MangaDescription(title: "Berserk", description: "Berserk es un manga creado por Kentaro Miura y posteriormente adaptado en anime, con un estilo épico fantástico y de fantasía oscura. Miura publicó un prototipo de Berserk en 1988.", author: "Kentaro Miura")
    }
}

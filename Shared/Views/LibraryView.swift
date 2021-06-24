//
//  LibraryView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct LibraryView: View {
    
    let recentManga: [Manga] = [
        Manga(id: 0, title: "One Piece", description: "One Piece es un anime y manga escrito e ilustrado por Eiichirō Oda y actualmente es el manga más comprado en el mundo.", author: "Echiro Oda", url: "#", coverUrl: "01"),
        Manga(id: 1, title: "I Shaved. Then I Brought a High School Girl Home", description: "Yoshida was swiftly rejected by his crush of 5 years. On his way home after drinking his sorrows away, he saw a high school girl sitting on the street. \"I'll let you do it with me, so let me stay\". \"Don't even joke about something like that\". And so, the story of living with the high school girl Sayu began. The slice-of-life romance story between a runaway high school girl and a 26 year old salaryman ensues.", author: "Shimesaba", url: "#", coverUrl: "02"),
        Manga(id: 2, title: "Berserk", description: "Berserk es un manga creado por Kentaro Miura y posteriormente adaptado en anime, con un estilo épico fantástico y de fantasía oscura. Miura publicó un prototipo de Berserk en 1988.", author: "Kentaro Miura", url: "#", coverUrl: "03"),
        Manga(id: 3, title: "Berserk", description: "Berserk es un manga creado por Kentaro Miura y posteriormente adaptado en anime, con un estilo épico fantástico y de fantasía oscura. Miura publicó un prototipo de Berserk en 1988.", author: "Kentaro Miura", url: "#", coverUrl: "04"),
        Manga(id: 4, title: "Berserk", description: "Berserk es un manga creado por Kentaro Miura y posteriormente adaptado en anime, con un estilo épico fantástico y de fantasía oscura. Miura publicó un prototipo de Berserk en 1988.", author: "Kentaro Miura", url: "#", coverUrl: "03")
    ]
    
    var body: some View {
        content
    }
    
    var content: some View {
        ScrollView {
            VStack(spacing: 0) {
                grid
                    .padding()
            }
            .navigationTitle("Library")
        }
    }
    
    
    var grid: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 180, maximum: 180), spacing: 16)],
            spacing: 16
        ) {
            ForEach(recentManga, id: \.id) { manga in
                VStack {
                    #if os(iOS)
                    NavigationLink(destination: MangaDetialView(manga: manga)) {
                        MangaItem(manga: manga)
                            .frame(height: 240)
                    }
                    #else
                    // TODO: present modal logic
                    MangaItem(manga: manga)
                        .frame(height: 240)
                    #endif
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

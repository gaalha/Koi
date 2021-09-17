//
//  MangaDetialView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI
import UIImageColors
import Introspect

struct MangaDetialView: View {
    
    @State var uiTabarController: UITabBarController?
    
    var manga: Manga
    
    var body: some View {
        #if os(iOS)
        content
            .edgesIgnoringSafeArea(.all)
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
                uiTabarController = UITabBarController
            }.onDisappear {
                uiTabarController?.tabBar.isHidden = false
            }
        #else
        content
        #endif
    }
    
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                ZStack(alignment: .bottom) {
                    Image(manga.coverUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 320, alignment: .topLeading)
                        .blur(radius: 8)
                        .clipped()
                    
                    DescriptionGradient()
                    
                    HStack {
                        Image(manga.coverUrl)
                            .resizable()
                            .frame(width: 105, height: 150, alignment: .leading)
                            .scaledToFill()
                        
                        VStack(alignment: .leading) {
                            MangaDescription(title: manga.title, description: manga.description, author: manga.author)
                            
                            MangaDetailActions()
                        }
                    }
                    .padding()
                }
            }
            .foregroundColor(.white)
            .cornerRadius(20)
            
            VStack {
                ForEach(0 ..< 10) { item in
                    ChapterListItem(
                        chapter: Chapter(name: "72 - Eclipse", url: "google.com", scanlator: "PlotTwist No Fansub", uploadDate: 1605420000000, downloaded: false)
                    )
                    Divider()
                }
            }
            .padding()
        }
        .toolbar {
            Button(action: {
                print("button pressed")
            }) {
                Image(systemName: "arrowshape.turn.up.right")
                    .foregroundColor(.blue)
            }
        }
    }
    
}

struct MangaDetialView_Previews: PreviewProvider {
    static var previews: some View {
        MangaDetialView(manga: Manga(id: 2, title: "Berserk", description: "Berserk es un manga creado por Kentaro Miura y posteriormente adaptado en anime, con un estilo épico fantástico y de fantasía oscura. Miura publicó un prototipo de Berserk en 1988.", author: "Kentaro Miura", url: "#", coverUrl: "13"))
    }
}

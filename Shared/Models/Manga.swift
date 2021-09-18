//
//  Manga.swift
//  Koi
//
// Manga chapters:
// /api/v1/manga/{mangaId}/chapters?onlineFetch=false
//
//  Created by Edgar Mejía on 20/6/21.
//

import SwiftUI

struct Manga: Identifiable, Decodable {
    
    var id: Int
    
    var sourceId: String?
    
    var title: String!
    
    var description: String?
    
    var author: String?
    
    var artist: String?
    
    var genre: [String]?
    
    var url: String?
    
    var thumbnailUrl: String!
    
    var initialized: Bool?
    
    var status: String?
    
    var inLibrary: Bool?
    
    var realUrl: String?
    
    var freshData: Bool?
    
    var source: Source?
    
//    var meta
    
}

let recentManga: [Manga] = [
    Manga(id: 0, title: "One Piece", description: "One Piece es un anime y manga escrito e ilustrado por Eiichirō Oda y actualmente es el manga más comprado en el mundo.", author: "Echiro Oda", url: "#", thumbnailUrl: "https://uploads.mangadex.org/covers/06cdf186-6bba-4ba2-a68d-2093e1d3b35f/64ff735c-6f6a-4dae-9b1c-9b6be43649c0.jpg"),
    Manga(id: 1, title: "I Shaved. Then I Brought a High School Girl Home", description: "Yoshida was swiftly rejected by his crush of 5 years. On his way home after drinking his sorrows away, he saw a high school girl sitting on the street. \"I'll let you do it with me, so let me stay\". \"Don't even joke about something like that\". And so, the story of living with the high school girl Sayu began. The slice-of-life romance story between a runaway high school girl and a 26 year old salaryman ensues.", author: "Shimesaba", url: "#", thumbnailUrl: "https://uploads.mangadex.org/covers/06cdf186-6bba-4ba2-a68d-2093e1d3b35f/64ff735c-6f6a-4dae-9b1c-9b6be43649c0.jpg")
]

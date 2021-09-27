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

//
//  Chapter.swift
//  Koi
//
//  Chapter list:
//  /api/v1/manga/{mangaId}/chapters?onlineFetch=false
//
//  Chapter detail:
//  /api/v1/manga/{mangaId}/chapter/{index}
//
//  Chapter images:
//  /api/v1/manga/{mangaId}/chapter/{chapterIndex/page/{pageIndex}
//
//  Created by Edgar Mejía on 20/6/21.
//

import SwiftUI

struct Chapter: Identifiable, Decodable {
    
    var id = UUID().uuidString
    
    var name: String!
    
    var url: String!
    
    var chapterNumber: Double?
    
    var scanlator: String?
    
    var mangaId: Int!
    
    var uploadDate: Int64?
    
    var bookmarked: Bool!
    
    var read: Bool!
    
    var downloaded: Bool!
    
    var lastPageRead: Int?
    
    var lastReadAt: Int64?
    
    var index: Int?
    
    var pageCount: Int?
    
    var chapterCount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name,
             url,
             chapterNumber,
             scanlator,
             mangaId,
             uploadDate,
             bookmarked,
             read,
             downloaded,
             lastPageRead,
             lastReadAt,
             index,
             pageCount,
             chapterCount
    }
    
}

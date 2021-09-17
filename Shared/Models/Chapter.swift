//
//  Chapter.swift
//  Koi
//
// Chapter images:
// /api/v1/manga/{mangaId}/chapter/{chapterId}/page/{pageId}
//
//  Created by Edgar Mejía on 20/6/21.
//

import SwiftUI

struct Chapter: Identifiable, Decodable {
    
    var id = UUID()
    
    var name: String!
    
    var url: String!
    
    var chapterNumber: Double!
    
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
    
}

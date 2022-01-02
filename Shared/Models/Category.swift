//
//  Category.swift
//  Koi
//
//  Fetch all categories:
//  /api/v1/category

//  Get one category content:
//  /api/v1/category/{categoryId}
//
//  Created by Edgar Mejía on 17/9/21.
//

import SwiftUI

struct Category: Identifiable, Decodable, Encodable {
    
    let id: Int
    
    let order: Int!
    
    let name: String!
    
    let `default`: Bool!
    
//    init(id: Int? = nil, order: Int? = nil, name: String? = nil, default: Bool? = nil) {
//        self.id = id ?? 0
//        self.order = order ?? 0
//        self.name = name ?? ""
//        self.default = `default` ?? false
//    }
    
}

//
//  Category.swift
//  Koi
//  /api/v1/category
//
//  Created by Edgar Mejía on 17/9/21.
//

import SwiftUI

struct Category: Identifiable, Decodable {
    
    let id: Int
    
    let order: Int!
    
    let name: String!
    
    let `default`: Bool!
    
}

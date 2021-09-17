//
//  Source.swift
//  Koi
//
//  Source list:
//  /api/v1/source/list
//
//  Created by Edgar Mejía on 1/7/21.
//

import SwiftUI

struct Source: Identifiable, Decodable {
    
    var id: String
    
    var name: String!
    
    var lang: String!
    
    var iconUrl: String!
    
    var supportsLatest: Bool!
    
    var isConfigurable: Bool!
    
    var isNsfw: Bool?
    
}

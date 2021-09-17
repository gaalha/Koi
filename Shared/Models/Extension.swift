//
//  Extension.swift
//  Koi
//
//  Extensions list:
//  /api/v1/extension/list
//
//  Install extension:
//  api/v1/extension/install/{pkgName}
//
//  Created by Edgar Mejía on 17/9/21.
//

import SwiftUI

struct Extension: Identifiable, Decodable {
    
    var id = UUID()
    
    var apkName: String!
    
    var iconUrl: String!
    
    var name: String!
    
    var pkgName: String!
    
    var versionName: String!
    
    var versionCode: Int!
    
    var lang: String!
    
    var isNsfw: Bool!
    
    var installed: Bool!
    
    var hasUpdate: Bool!
    
    var obsolete: Bool!
    
}

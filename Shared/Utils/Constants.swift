//
//  Constants.swift
//  Koi
//
//  Created by Edgar Mejía on 18/9/21.
//

import Foundation

struct Constants {
    
    struct General {
        
        static let APP_NAME = "Koi"
        
        static let APP_VERSION = "v0.0.2"
        
    }

    struct API {
        
        static let BASE = "/api/v1"
        
        struct TACHIDESK {
            
            static let CATEGORY = "\(BASE)/category"
            
            static let MANGA = "\(BASE)/manga"
            
            static let SETTING = "\(BASE)/settings"
            
        }
        
    }
    
}

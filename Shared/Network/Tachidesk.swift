//
//  Request.swift
//  Koi
//
//  Created by Edgar Mejía on 19/9/21.
//

import Foundation
import SwiftUI

class Tachidesk {
    
    @AppStorage("TACHIDESK_PORT") var TACHIDESK_PORT = "4567"
    
    @AppStorage("TACHIDESK_HOST") var TACHIDESK_HOST = "http://192.168.1.1"
    
    func getPort() -> String {
        return self.TACHIDESK_PORT
    }
    
    func getHost() -> String {
        return self.TACHIDESK_HOST
    }
    
    func getFullHost() -> String {
        return "\(self.TACHIDESK_HOST):\(self.TACHIDESK_PORT)"
    }
    
}

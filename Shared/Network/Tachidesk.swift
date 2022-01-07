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
    
    @AppStorage("TACHIDESK_HOST") var TACHIDESK_HOST = "http://192.168.1.23"
    
    func getPort() -> String {
        TACHIDESK_PORT
    }
    
    func getHost() -> String {
        TACHIDESK_HOST
    }
    
    func getFullHost() -> String {
        "\(TACHIDESK_HOST):\(TACHIDESK_PORT)"
    }
    
}

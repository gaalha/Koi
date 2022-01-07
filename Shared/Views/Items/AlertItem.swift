//
//  AlertItem.swift
//  Koi
//
//  Created by Edgar Mejía on 26/9/21.
//

import SwiftUI

struct AlertItem: View {
    
    var icon: String
    
    var message: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
            Text(message).padding(.top)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16.0))
    }
}

struct AlertItem_Previews: PreviewProvider {
    static var previews: some View {
        AlertItem(icon: "rectangle.expand.vertical", message: "Horizontal pagination")
    }
}

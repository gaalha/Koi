//
//  TagView.swift
//  Koi
//
//  Created by Edgar Mejía on 2/1/22.
//

import SwiftUI

struct TagView: View {
    
    var tag: String
    
    var body: some View {
        Text(tag)
            .foregroundColor(.white)
            .font(.caption2)
            .padding(4)
            .background(Color.accentColor.cornerRadius(10))
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: "Hola")
    }
}

//
//  CloseButton.swift
//  Koi
//
//  Created by Edgar Mejía on 26/9/21.
//

import SwiftUI

struct CloseButton: View {
    var body: some View {
        Image(systemName: "xmark")
            .frame(width: 5, height: 5)
            .foregroundColor(.white)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(Circle())
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}

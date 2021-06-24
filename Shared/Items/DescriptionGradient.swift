//
//  DescriptionGradient.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct DescriptionGradient: View {
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.7), .white.opacity(0.1)]), startPoint: .bottom, endPoint: .top)
            )
        }
    }
}

struct DescriptionGradient_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionGradient()
    }
}

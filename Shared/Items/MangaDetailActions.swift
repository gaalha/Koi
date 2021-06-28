//
//  MangaDetailActions.swift
//  Koi
//
//  Created by Edgar Mejía on 24/6/21.
//

import SwiftUI
import UIImageColors

struct MangaDetailActions: View {
    
    var colors: UIImageColors
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Button(action: {
                    print("button pressed")
                }) {
                    buttonStyle(icon: "play")
                }
                
                Button(action: {
                    print("button pressed")
                }) {
                    buttonStyle(icon: "bookmark")
                }
                
                Button(action: {
                    print("button pressed")
                }) {
                    buttonStyle(icon: "arrow.2.squarepath")
                }
            }
        }
        .padding(.horizontal)
    }
    
    func buttonStyle(icon: String) -> some View {
        Image(systemName: icon)
            .frame(height: 10)
            .padding()
            .background(Color(colors.secondary))
            .clipShape(Circle())
            .foregroundColor(Color(colors.background))
            .shadow(radius: 5)
    }
}

struct MangaDetailActions_Previews: PreviewProvider {
    static var previews: some View {
        MangaDetailActions(colors: UIImageColors(background: UIColor(.white), primary: UIColor(.white), secondary: UIColor(.blue), detail: UIColor(.blue)))
    }
}

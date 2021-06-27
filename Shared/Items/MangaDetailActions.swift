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
                    Image(systemName: "play")
                        .frame(height: 10)
                        .padding()
                        .background(Color(colors.secondary))
                        .clipShape(Circle())
                        .foregroundColor(Color(colors.background))
                        .shadow(radius: 5)
                }
                
                Button(action: {
                    print("button pressed")
                }) {
                    Image(systemName: "bookmark")
                        .frame(height: 10)
                        .padding()
                        .background(Color(colors.secondary))
                        .clipShape(Circle())
                        .foregroundColor(Color(colors.background))
                        .shadow(radius: 5)
                }
                
                Button(action: {
                    print("button pressed")
                }) {
                    Image(systemName: "arrow.2.squarepath")
                        .frame(height: 10)
                        .padding()
                        .background(Color(colors.secondary))
                        .clipShape(Circle())
                        .foregroundColor(Color(colors.background))
                        .shadow(radius: 5)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MangaDetailActions_Previews: PreviewProvider {
    static var previews: some View {
        MangaDetailActions(colors: UIImageColors(background: UIColor(.white), primary: UIColor(.white), secondary: UIColor(.blue), detail: UIColor(.blue)))
    }
}

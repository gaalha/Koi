//
//  HistoryView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct HistoryView: View {
    
    let url = URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!

    var body: some View {
        AsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut)
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .transition(.scale(scale: 0.1, anchor: .center))
            case .failure:
                Image(systemName: "xmark.octagon.fill")
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 150, height: 250)
        .background(Color.gray)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

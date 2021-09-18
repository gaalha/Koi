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
//        Text("Hello, from History!")
//        AsyncImage
        AsyncImage(
            url: url
        )
        .aspectRatio(contentMode: .fit)
    }
}

//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView()
//    }
//}

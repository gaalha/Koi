//
//  ChapterListItem.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct ChapterListItem: View {
    var body: some View {
//        VStack(alignment: .leading, content: {
//            Text("71 - Eclipse")
//            Text("PlotTwist No Fansub")
//                .font(.footnote)
//                .foregroundColor(Color.gray)
//        })
//        .padding(3.0)
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4.0) {
                Text("71 - Eclipse")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
                Text("PlotTwist No Fansub")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct ChapterListItem_Previews: PreviewProvider {
    static var previews: some View {
        ChapterListItem()
    }
}

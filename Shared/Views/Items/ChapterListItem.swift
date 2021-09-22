//
//  ChapterListItem.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct ChapterListItem: View {
    
    var chapter: Chapter
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(chapter.name)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(chapter.scanlator ?? "")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            DownloadButton(chapter: chapter)
        }
    }
}

struct ChapterListItem_Previews: PreviewProvider {
    static var previews: some View {
        ChapterListItem(chapter: Chapter(name: "72 - Eclipse", url: "google.com", scanlator: "PlotTwist No Fansub", uploadDate: 1605420000000, downloaded: false))
    }
}

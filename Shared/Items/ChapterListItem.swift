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
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(chapter.title)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
                Text(chapter.fanSub ?? "")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            DownloadButton(chapter: Chapter(id: 1, title: "72 - Eclipse", fanSub: "PlotTwist No Fansub", date: "12/11/94", url: "google.com", download: false))
        }
    }
}

struct ChapterListItem_Previews: PreviewProvider {
    static var previews: some View {
        ChapterListItem(chapter: Chapter(id: 1, title: "72 - Eclipse", fanSub: "PlotTwist No Fansub", date: "12/11/94", url: "google.com", download: false))
    }
}

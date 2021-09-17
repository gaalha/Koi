//
//  DownloadButton.swift
//  Koi
//
//  Created by Edgar Mejía on 23/6/21.
//

import SwiftUI

struct DownloadButton: View {
    
    var chapter: Chapter
    
    var body: some View {
        Button(action: {
            // Add target for download
            print("button pressed")
        }) {
            Image(systemName: "icloud.and.arrow.down")
                .foregroundColor(.blue)
        }
    }
}

struct DownloadButton_Previews: PreviewProvider {
    static var previews: some View {
        DownloadButton(chapter: Chapter(id: 1, title: "72 - Eclipse", fanSub: "PlotTwist No Fansub", date: "12/11/94", url: "google.com", download: false))
    }
}

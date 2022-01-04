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
            Image(systemName: "arrow.down.circle")
                .foregroundColor(.blue)
        }
    }
}

struct DownloadButton_Previews: PreviewProvider {
    static var previews: some View {
        DownloadButton(chapter: Chapter(name: "72 - Eclipse", url: "google.com", scanlator: "PlotTwist No Fansub", uploadDate: 1605420000000, downloaded: false))
    }
}

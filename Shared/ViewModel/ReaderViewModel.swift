//
//  ReaderViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 24/9/21.
//

import SwiftUI

class ReaderViewModel: ObservableObject {
    
    @Published var showMangaReader: Bool = false
    
    @Published var currentChapter: Chapter? = nil
    
}

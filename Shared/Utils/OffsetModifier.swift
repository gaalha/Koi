//
//  OffsetModifier.swift
//  Koi
//
//  Created by Edgar Mejía on 25/9/21.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    @State var startOffset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader { proxy in
                Color.clear
                    .preference(key: OffsetKey.self, value: proxy.frame(in: .global).minY)
            })
            .onPreferenceChange(OffsetKey.self) { offset in
                if startOffset == 0 {
                    startOffset = offset
                }
                self.offset = offset - startOffset
            }
    }
    
}

struct OffsetKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

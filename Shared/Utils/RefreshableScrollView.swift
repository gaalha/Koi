//
//  RefreshableScrollView.swift
//  Koi
//
//  Created by Edgar Mejía on 25/9/21.
//

import Foundation
import SwiftUI

struct RefreshableScrollView<Content: View>: View {
    
    var content: Content
    
    var onRefresh: () async ->()
    
    init(title: String, tintColor: Color, @ViewBuilder content: @escaping ()-> Content, onRefresh: @escaping () async ->()) {
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        List {
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
        }
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
    }
    
}

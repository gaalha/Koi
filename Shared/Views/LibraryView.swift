//
//  LibraryView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI
import Refresh

struct LibraryView: View {
    
    @State var categorySelected = 0
    
    @State var categories: [Category] = []
    
    @State var categoriesLoaded: Bool = false
    
    @State var mangaList: [Manga] = []
    
    @State var mangaListLoaded: Bool = false
    
    // Refresh plugin:
    @State private var headerRefreshing: Bool = false
    @State private var footerRefreshing: Bool = false
    @State private var noMore: Bool = false
    
    var body: some View {
        content
            .navigationTitle("Library")
            .onAppear {
                fetchCategories()
            }
    }
    
    var content: some View {
        ScrollView {
            RefreshHeader(refreshing: $headerRefreshing, action: fetchCategories) { progress in
                if self.headerRefreshing {
//                    Text("refreshing...")
                    ProgressView()
                } else {
                    Text("Pull to refresh")
                }
            }
            
            if !categoriesLoaded && !mangaListLoaded {
                VStack(alignment: .leading) {
                    ProgressView()
                        .padding(.top)
                }
            } else {
                VStack(spacing: 0) {
                    // Categories
                    if categoriesLoaded && !self.categories.isEmpty {
                        categoriesSection
                    }
                    
                    // Library
                    if mangaListLoaded && !self.mangaList.isEmpty {
                        MangaGrid(mangaList: mangaList)
                            .padding()
                    } else if mangaListLoaded && self.mangaList.isEmpty {
                        VStack(alignment: .center) {
                            Text("Nothing to show 🥲")
                                .padding(.top)
                            HStack {
                                Button("Retry to load", action: fetchCategories)
                            }
                            .buttonStyle(.bordered)
                        }
                    } else if !mangaListLoaded {
                        ProgressView()
                    }
                }
            }
            
//            RefreshFooter(refreshing: $footerRefreshing, action: fetchCategories) {
//                if self.noMore {
//                    Text("No more data !")
//                } else {
//                    Text("refreshing...")
//                }
//            }
//            .noMore(noMore)
//            .preload(offset: 50)
        }
        .enableRefresh()
    }
    
    var categoriesSection: some View {
        Picker("", selection: $categorySelected) {
            ForEach(self.categories, id: \.id) { category in
                Text(category.name)
            }
        }
        .onChange(of: categorySelected) {tag in
            mangaListLoaded = false
            fetchOneCategory(categoryId: categorySelected)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    func fetchCategories() {
        CategoryViewModel().getAll { result in
            switch result {
            case let .success(categories):
                self.categoriesLoaded = true
                if categories != nil {
                    self.categories = categories!
                    fetchOneCategory(categoryId: categorySelected)
                } else {
                    self.headerRefreshing = false
                    self.mangaListLoaded = true
                }
            
            case let .failure(error):
                print(error)
                self.categoriesLoaded = true
                self.headerRefreshing = false
            }
        }
    }
    
    func fetchOneCategory(categoryId: Int) {
        CategoryViewModel().getOne(id: categoryId, completion: { result in
            switch result {
            case let .success(mangaList):
                self.mangaListLoaded = true
                self.headerRefreshing = false
                if mangaList != nil {
                    self.mangaList = mangaList!
                }
                
            case let .failure(error):
                print(error)
                self.mangaListLoaded = true
                self.headerRefreshing = false
            }
        })
    }
}


struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

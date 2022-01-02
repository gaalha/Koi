//
//  LibraryView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI
import Refresh

struct LibraryView: View {
    
    @StateObject private var categoryViewModel = CategoryViewModel()
    
    @State var categorySelected = 0
    
    @State var categoriesLoaded: Bool = false
    
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
                    if categoriesLoaded && !categoryViewModel.categories.isEmpty {
                        categoriesSection
                    }
                    
                    // Library
                    if mangaListLoaded && !categoryViewModel.mangaList.isEmpty {
                        MangaGrid(mangaList: categoryViewModel.mangaList)
                            .padding()
                    } else if mangaListLoaded && categoryViewModel.mangaList.isEmpty {
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
        }
        .enableRefresh()
    }
    
    var categoriesSection: some View {
        Picker("", selection: $categorySelected) {
            ForEach(categoryViewModel.categories, id: \.id) { category in
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
        categoryViewModel.getAll() { err in
            if let err = err {
                print(err)
                self.categoriesLoaded = true
                self.headerRefreshing = false
                return
            }
            
            self.categoriesLoaded = true
            if categoryViewModel.category != nil {
                fetchOneCategory(categoryId: categorySelected)
            } else {
                self.headerRefreshing = false
                self.mangaListLoaded = true
            }
        }
    }
    
    func fetchOneCategory(categoryId: Int) {
        categoryViewModel.getOne(id: categoryId) { err in
            if let err = err {
                print(err)
                self.mangaListLoaded = true
                self.headerRefreshing = false
                return
            }
            
            self.mangaListLoaded = true
            self.headerRefreshing = false
        }
    }
}


struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

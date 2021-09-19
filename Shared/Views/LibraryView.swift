//
//  LibraryView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct LibraryView: View {
    
    @State var categorySelected = 0
    
    @State var categories: [Category] = []
    
    @State var categoriesLoaded: Bool = false
    
    @State var mangaList: [Manga] = []
    
    @State var mangaListLoaded: Bool = false
    
    var body: some View {
        content
            .navigationTitle("Library")
            .onAppear {
                fetchCategories()
            }
    }
    
    var content: some View {
        ScrollView {
            if !categoriesLoaded && !mangaListLoaded {
                VStack(alignment: .leading) {
                    ProgressView()
                }
            } else {
                VStack(spacing: 0) {
                    if categoriesLoaded && self.categories.count > 0 {
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
                    
                    if mangaListLoaded && !self.mangaList.isEmpty {
                        MangaGrid(mangaList: mangaList)
                            .padding()
                    } else if mangaListLoaded && self.mangaList.isEmpty {
                        Text("Nothing to show 🥲")
                            .padding(.top)
                    } else if !mangaListLoaded {
                        ProgressView()
                    }
                }
            }
        }
    }
    
    func fetchCategories() {
        CategoryViewModel().getAll { (categories) in
            self.categories = categories
            self.categoriesLoaded = true
            fetchOneCategory(categoryId: categorySelected)
        }
    }
    
    func fetchOneCategory(categoryId: Int) {
        CategoryViewModel().getOne(id: categoryId, completion: { (mangaList) in
            self.mangaList = mangaList
            self.mangaListLoaded = true
        })
    }
}


struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

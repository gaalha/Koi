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
                CategoryViewModel().getAll { (categories) in
                    self.categories = categories
                    self.categoriesLoaded = true
                    
                    CategoryViewModel().getOne(id: categorySelected, completion: { (mangaList) in
                        self.mangaList = mangaList
                        self.mangaListLoaded = true
                    })
                }
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
                            
                            CategoryViewModel().getOne(id: categorySelected, completion: { (mangaList) in
                                self.mangaList = mangaList
                                self.mangaListLoaded = true
                            })
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }
                    
                    if mangaListLoaded && self.mangaList.count > 0  {
                        MangaGrid(mangaList: mangaList)
                            .padding()
                    } else if mangaListLoaded && self.mangaList.count == 0 {
                        Text("No hay series que mostrar 🥲")
                    } else if !mangaListLoaded {
                        ProgressView()
                    }
                    
                }
            }
        }
    }
    
    func categoryChange(_ tag: Int) {
        print("Color tag: \(tag)")
    }
}


struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

//
//  LibraryView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct LibraryView: View {
    
    @StateObject private var categoryViewModel = CategoryViewModel()
    
    @State var categorySelected = 0
    
    @State var categoriesLoaded: Bool = false
    
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
//        .introspectScrollView { scrollView in
//            self.fetchCategories()
//            scrollView.refreshControl = UIRefreshControl()
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                scrollView.refreshControl?.endRefreshing()
//            }
//        }
    }
    
    var categoriesSection: some View {
        Picker("", selection: $categorySelected) {
            ForEach(categoryViewModel.categories, id: \.id) { category in
                Text(category.name)
            }
        }
        .onChange(of: categorySelected) { tag in
            mangaListLoaded = false
            fetchOneCategory(categoryId: categorySelected)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    func refresh(sender: AnyObject) {
        fetchCategories()
    }
    
    func fetchCategories() {
        categoryViewModel.getAll() { err in
            if let err = err {
                print(err)
                self.categoriesLoaded = true
                return
            }
            
            self.categoriesLoaded = true
            if !categoryViewModel.categories.isEmpty {
                fetchOneCategory(categoryId: categorySelected)
            } else {
                self.mangaListLoaded = true
            }
        }
    }
    
    func fetchOneCategory(categoryId: Int) {
        categoryViewModel.getOne(id: categoryId) { err in
            self.mangaListLoaded = true
            if let err = err {
                print(err)
                return
            }
        }
    }
}


struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

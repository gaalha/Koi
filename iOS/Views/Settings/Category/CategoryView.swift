//
//  CategoryView.swift
//  Koi
//
//  Created by Edgar Mejía on 30/12/21.
//

import Foundation
import SwiftUI

struct CategoryView: View {
    
    @StateObject private var categoryViewModel = CategoryViewModel()
    
    @State var isLoading: Bool = true
    
    @State var hasError: Bool = false
    
    @State var id: Int = 0
    
    @State var name: String = ""
    
    @State var `default`: Bool = false
    
    @State private var showForm = false
    
    var body: some View {
        #if os(iOS)
        content
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Categories")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.id = 0
                    self.name = ""
                    self.default = false
                    self.showForm.toggle()
                }) {
                    Text("Add")
                }
                .sheet(isPresented: $showForm, content: {
                    CategoryFormView(id: $id, name: $name, default: $default)
                })
                
            }
        }
        .onAppear {
            fetchCategories()
        }
        #else
        content
        #endif
    }
    
    var content: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                if !hasError {
                    List {
                        ForEach(categoryViewModel.categories, id: \.id) { category in
                            Text(category.name)
                                .swipeActions {
                                    if !category.default {
                                        Button("Default") {
                                            print("Now is default")
                                        }
                                        .tint(.accentColor)
                                        Button("Delete") {
                                            print("Deleted")
                                        }
                                        .tint(.red)
                                    }
                                    
                                    Button("Modify") {
                                        self.id = category.id
                                        self.name = category.name
                                        self.default = category.default
                                        self.showForm.toggle()
                                    }
                                    .sheet(isPresented: $showForm, content: {
                                        CategoryFormView(id: $id, name: $name, default: $default)
                                    })
                                    .tint(.blue)
                                }
                        }
                    }
                } else {
                    VStack(alignment: .center) {
                        Text("Nothing to show 🥲")
                            .padding(.top)
                        HStack {
                            Button("Retry to load", action: fetchCategories)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
        }
    }
    
    func fetchCategories() {
        categoryViewModel.getAll() { err in
            self.isLoading = false
            if let err = err {
                print(err)
                self.hasError = true
                return
            }
        }
    }
    
}

//
//  CategoryFormView.swift
//  Koi
//
//  Created by Edgar Mejía on 30/12/21.
//

import SwiftUI

struct CategoryFormView: View {
    
    @StateObject private var categoryViewModel = CategoryViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var id: Int
    
    @Binding var name: String
    
    @Binding var `default`: Bool
    
    @State var isSaving: Bool = false
    
    var body: some View {
        NavigationView {
            #if os(iOS)
            content
                .navigationTitle("Edit categories")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {}, label: {
                            Text("Done")
                        })
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: close, label: {
                            Text("Cancel")
                        })
                    }
                }
            #else
            content
            #endif
        }
        
    }
    
    var content: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Name:")
                            .foregroundColor(.gray)
                        Spacer()
                        TextField("", text: $name)
                    }
                    
                    Toggle(isOn: $default, label: {
                        Text("Default")
                    })
                }
            }
        }
    }
    
    func saveCategory(id: Int?, name: String!, default: Bool = false) {
        isSaving = true
        categoryViewModel.saveOne(name: name, default: `default`) { err in
            isSaving = false
            if let err = err {
                print(err)
                return
            }
        }
    }
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

//struct CategoryFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryFormView(name: "", default: false)
//    }
//}

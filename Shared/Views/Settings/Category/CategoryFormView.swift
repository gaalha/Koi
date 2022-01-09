//
//  CategoryFormView.swift
//  Koi
//
//  Created by Edgar Mejía on 30/12/21.
//

import SwiftUI

struct CategoryFormView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var name: String
    
    @Binding var `default`: Bool
    
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
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

//struct CategoryFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryFormView(name: "", default: false)
//    }
//}

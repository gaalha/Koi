//
//  TachideskOptionsView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/9/21.
//

import SwiftUI
import Foundation

struct TachideskOptionsView: View {
    
    @AppStorage("TACHIDESK_PORT") var port = Tachidesk().getPort()
    
    @AppStorage("TACHIDESK_HOST") var host = Tachidesk().getHost()
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("HOST:")
                            .foregroundColor(.gray)
                        Spacer()
                        TextField("", text: $host)
                    }
                    
                    HStack {
                        Text("PORT:")
                            .foregroundColor(.gray)
                        Spacer()
                        TextField("", text: $port)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Set Tachideks URL")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.testConnection()
                }) {
                    Text("Test")
                }
            }
        }
    }
    
    private func testConnection() {
        // TODO
    }
}

struct TachideskOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        TachideskOptionsView()
    }
}

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
    
    @State var isTestingConnection: Bool = false
    
    @State var testResultMessage: String = ""
    
    @State var testResultIcon: String = ""
    
    @State var showTestAlert: Bool = false
    
    var body: some View {
        #if os(iOS)
        content
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Set Tachideks URL")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.isTestingConnection = true
                    self.testConnection()
                }) {
                    Text("Test")
                }.disabled(self.isTestingConnection)
            }
        }
        #else
        content
        #endif
    }
    
    var content: some View {
        ZStack {
            VStack {
                Form {
                    Section {
                        HStack {
                            Text("Host:")
                                .foregroundColor(.gray)
                            Spacer()
                            TextField("", text: $host)
                        }
                        
                        HStack {
                            Text("Port:")
                                .foregroundColor(.gray)
                            Spacer()
                            TextField("", text: $port)
                        }
                    }
                }
            }
            
            if showTestAlert {
                alertContent
            }
        }
    }
    
    var alertContent: some View {
        AlertItem(icon: self.testResultIcon, message: self.testResultMessage)
    }
    
    func hideTestAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showTestAlert = false
        }
    }
    
    func testConnection() {
        CategoryViewModel().getAll { result in
            switch result {
            case let .success(category):
                if category==nil {
                    setErrorResult()
                } else {
                    setSuccessResult()
                }
            
            case let .failure(error):
                print(error)
                setErrorResult()
            }
        }
    }
    
    func setSuccessResult() {
        self.isTestingConnection = false
        self.testResultIcon = "checkmark.icloud"
        self.testResultMessage = "Success conected to Tachidesk!"
        self.showTestAlert = true
        self.hideTestAlert()
    }
    
    func setErrorResult() {
        self.isTestingConnection = false
        self.testResultIcon = "xmark.icloud"
        self.testResultMessage = "Failed to conect to Tachidesk, try with other HOST or/and PORT."
        self.showTestAlert = true
        self.hideTestAlert()
    }
}

struct TachideskOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        TachideskOptionsView()
    }
}

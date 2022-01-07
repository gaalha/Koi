//
//  HistoryView.swift
//  Koi
//
//  Created by Edgar Mejía on 21/6/21.
//

import SwiftUI

struct HistoryView: View {

    var body: some View {
        HStack {
            Button(action: {
                print("Touched")
            }, label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Library")
                }
            })
                .buttonStyle(.bordered)
                .background(.clear)
                .foregroundColor(.black)
                .cornerRadius(18)
            
            Button(action: {
                print("Touched")
            }, label: {
                HStack {
                    Image(systemName: "minus")
                    Text("Library")
                }
            })
                .buttonStyle(.bordered)
                .background(.tint)
                .foregroundColor(.white)
                .cornerRadius(18)
        }
//        AsyncImage(
//            url: url,
//            transaction: Transaction(animation: .easeInOut)
//        ) { phase in
//            switch phase {
//            case .empty:
//                ProgressView()
//            case .success(let image):
//                image
//                    .resizable()
//                    .transition(.scale(scale: 0.1, anchor: .center))
//            case .failure:
//                Image(systemName: "xmark.octagon.fill")
//            @unknown default:
//                EmptyView()
//            }
//        }
//        .frame(width: 150, height: 250)
//        .background(Color.gray)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

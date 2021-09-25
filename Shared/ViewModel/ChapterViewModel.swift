//
//  ChapterViewModel.swift
//  Koi
//
//  Fetch chapters:
//  /api/v1/manga/{mangaId}/chapter/{chapterIndex}
//
//  Created by Edgar Mejía on 18/9/21.
//

import Foundation

class ChapterViewModel {
    
    func getDetail(mangaId: Int, chapterIndex: Int, completion: @escaping (Result<Chapter?, Error>) -> ()) {
        guard let url = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(mangaId)/chapter/\(chapterIndex)")
        else { return completion(.success(nil)) }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if data == nil { return completion(.success(nil)) }
            let chapter = try! JSONDecoder().decode(Chapter.self, from: data!)
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(chapter))
                }
            }
        }
        .resume()
    }
    
}

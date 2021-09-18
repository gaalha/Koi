//
//  MangaViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 18/9/21.
//
import Foundation

class MangaViewModel {
    
    private var apiBase: String = "http://192.168.1.8:4567"
    
    private var apiPart: String = "/api/v1/manga"
    
    func getOne(id: Int, completion: @escaping (Manga) -> ()) {
        guard let url = URL(string: "\(apiBase)\(apiPart)/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let mangaDetail = try! JSONDecoder().decode(Manga.self, from: data!)
            
            DispatchQueue.main.async {
                completion(mangaDetail)
            }
        }
        .resume()
    }
    
    func getThunmnail(mangaId: Int, completion: @escaping (Manga) -> ()) {
        guard let url = URL(string: "\(apiBase)\(apiPart)/\(mangaId)/thumbnail") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let mangaDetail = try! JSONDecoder().decode(Manga.self, from: data!)
            
            DispatchQueue.main.async {
                completion(mangaDetail)
            }
        }
        .resume()
    }
    
}

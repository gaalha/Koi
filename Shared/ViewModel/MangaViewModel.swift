//
//  MangaViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 18/9/21.
//
import Foundation

class MangaViewModel {
    
    private var apiPart: String = "/api/v1/manga"
    
    func getOne(id: Int, completion: @escaping (Manga) -> ()) {
        guard let url = URL(string: "\(Constants.TACHIDESK_HOST)\(apiPart)/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let mangaDetail = try! JSONDecoder().decode(Manga.self, from: data!)
            
            DispatchQueue.main.async {
                completion(mangaDetail)
            }
        }
        .resume()
    }
    
    func getThunmnail(mangaId: Int, completion: @escaping (Manga) -> ()) {
        guard let url = URL(string: "\(Constants.TACHIDESK_HOST)\(apiPart)/\(mangaId)/thumbnail")
        else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let mangaDetail = try! JSONDecoder().decode(Manga.self, from: data!)
            
            DispatchQueue.main.async {
                completion(mangaDetail)
            }
        }
        .resume()
    }
    
    func getChapters(mangaId: Int, completion: @escaping ([Chapter]) -> ()) {
        guard let url = URL(string: "\(Constants.TACHIDESK_HOST)\(apiPart)/\(mangaId)/chapters?onlineFetch=false")
        else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let chapterList = try! JSONDecoder().decode([Chapter].self, from: data!)
            
            DispatchQueue.main.async {
                completion(chapterList)
            }
        }
        .resume()
    }
    
}

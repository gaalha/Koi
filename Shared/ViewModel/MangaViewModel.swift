//
//  MangaViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 18/9/21.
//
import Foundation

class MangaViewModel {
    
    private var apiPart: String = "/api/v1/manga"
    
    func getOne(id: Int, completion: @escaping (Result<Manga?, Error>) -> ()) {
        guard let url = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(id)")
        else { return completion(.success(nil)) }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if data == nil { return completion(.success(nil)) }
            let mangaDetail = try! JSONDecoder().decode(Manga.self, from: data!)
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(mangaDetail))
                }
            }
        }
        .resume()
    }
    
    func getThunmnail(mangaId: Int, completion: @escaping (Result<Manga?, Error>) -> ()) {
        guard let url = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(mangaId)/thumbnail")
        else { return completion(.success(nil)) }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if data == nil { return completion(.success(nil)) }
            let mangaDetail = try! JSONDecoder().decode(Manga.self, from: data!)
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(mangaDetail))
                }
            }
        }
        .resume()
    }
    
    func getChapters(mangaId: Int, completion: @escaping (Result<[Chapter]?, Error>) -> ()) {
        guard let url = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(mangaId)/chapters?onlineFetch=false")
        else { return completion(.success(nil)) }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if data == nil { return completion(.success(nil)) }
            let chapterList = try! JSONDecoder().decode([Chapter].self, from: data!)
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(chapterList))
                }
            }
        }
        .resume()
    }
    
}

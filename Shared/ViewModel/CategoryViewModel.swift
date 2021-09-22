//
//  CategoryViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 17/9/21.
//

import Foundation

class CategoryViewModel {
    
    func getAll(completion: @escaping (Result<[Category]?, Error>) -> ()) {
        guard let url = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.CATEGORY)")
        else { return completion(.success(nil)) }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if data == nil { return completion(.success(nil)) }
            let categories = try! JSONDecoder().decode([Category].self, from: data!)
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(categories))
                }
            }
        }
        .resume()
    }
    
    func getOne(id: Int, completion: @escaping (Result<[Manga]?, Error>) -> ()) {
        guard let url = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.CATEGORY)/\(id)")
        else { return completion(.success(nil)) }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if data == nil { return completion(.success(nil)) }
            let mangaList = try! JSONDecoder().decode([Manga].self, from: data!)
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(mangaList))
                }
            }
        }
        .resume()
    }
    
}

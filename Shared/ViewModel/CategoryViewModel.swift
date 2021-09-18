//
//  CategoryViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 17/9/21.
//

import Foundation

class CategoryViewModel {
    
    private var apiPart: String = "/api/v1/category"
    
    func getAll(completion: @escaping ([Category]) -> ()) {
        guard let url = URL(string: "\(Constants.TACHIDESK_HOST)\(apiPart)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let categories = try! JSONDecoder().decode([Category].self, from: data!)
            print(categories)
            
            DispatchQueue.main.async {
                completion(categories)
            }
        }
        .resume()
    }
    
    func getOne(id: Int, completion: @escaping ([Manga]) -> ()) {
        guard let url = URL(string: "\(Constants.TACHIDESK_HOST)\(apiPart)/\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let mangaList = try! JSONDecoder().decode([Manga].self, from: data!)
            
            DispatchQueue.main.async {
                completion(mangaList)
            }
        }
        .resume()
    }
    
}

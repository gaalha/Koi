//
//  CategoryViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 17/9/21.
//

import Foundation

class CategoryViewModel: ObservableObject {
    
    private let api = NetworkController()
    
    @Published var category: Category? = nil
    
    @Published var categories: [Category] = []
    
    @Published var mangaList: [Manga] = []
    
    func getAll(completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.CATEGORY)")
        else { return completion(nil) }
        
        api.GET(url: url, completion: { response in
            switch response {
            case let .success(data):
                if data == nil { return completion(nil) }
                self.categories = try! JSONDecoder().decode([Category].self, from: data!)
                completion(nil)
                
            case let .failure(error):
                completion(error)
            }
            
        })
    }
    
    func getOne(id: Int, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.CATEGORY)/\(id)")
        else { return completion(nil) }
        
        api.GET(url: url, completion: { response in
            switch response {
            case let .success(data):
                if data == nil { return completion(nil) }
                self.mangaList = try! JSONDecoder().decode([Manga].self, from: data!)
                completion(nil)
                
            case let .failure(error):
                completion(error)
            }
            
        })
    }
    
}

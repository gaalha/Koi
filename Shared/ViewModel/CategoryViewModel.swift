//
//  CategoryViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 17/9/21.
//

import Foundation
import Alamofire

class CategoryViewModel: ObservableObject {
    
    @Published var category: Category? = nil
    
    @Published var categories: [Category] = []
    
    @Published var mangaList: [Manga] = []
    
    func getAll(completion: @escaping (Error?) -> ()) {
        let url = "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.CATEGORY)"
        
        AF.request(url).responseDecodable(of: [Category].self) { response in
            switch response.result {
            case .success(_):
                self.categories = response.value!
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getOne(id: Int, completion: @escaping (Error?) -> ()) {
        let url = "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.CATEGORY)/\(id)"
        
        AF.request(url).responseDecodable(of: [Manga].self) { response in
            switch response.result {
            case .success(_):
                self.mangaList = response.value!
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func saveOne(id: Int?, name: String, default: Bool, completion: @escaping (Error?) -> ()) {
        let url = "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.CATEGORY)/\((id==nil || id==0) ? "" : String(id!))"
        let params = ["name": name, "default": `default`] as [String : Any]
        let methodType = (id==nil || id==0) ? HTTPMethod.post : HTTPMethod.patch
        
        AF.request(url, method: methodType, parameters: params).response { response in
            switch response.result {
            case .success(_):
                if let status = response.response?.statusCode {
                    if status == 200 {
                        completion(nil)
                    } else {
                        break
                    }
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func deleteOne(id: Int, completion: @escaping (Error?) -> ()) {
        let url = "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.CATEGORY)/\(id)"
        
        AF.request(url, method: .delete).response { response in
            switch response.result {
            case .success(_):
                if let status = response.response?.statusCode {
                    if status == 200 {
                        completion(nil)
                    } else {
                        break
                    }
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}

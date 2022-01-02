//
//  MangaViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 18/9/21.
//
import Foundation
import Alamofire

class MangaViewModel: ObservableObject {
    
    @Published var manga: Manga? = nil
    
    @Published var chapterList: [Chapter] = []
    
    func getOne(id: Int, completion: @escaping (Error?) -> ()) {
        let url = "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(id)"
        
        AF.request(url).responseDecodable(of: Manga.self) { response in
            switch response.result {
            case .success(_):
                self.manga = response.value!
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getThunmnail(mangaId: Int, completion: @escaping (Error?) -> ()) {
        let url = "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(mangaId)/thumbnail"
        
        AF.request(url).responseDecodable(of: Manga.self) { response in
            switch response.result {
            case .success(_):
                self.manga = response.value!
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getChapters(mangaId: Int, completion: @escaping (Error?) -> ()) {
        let url = "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.MANGA)/\(mangaId)/chapters?onlineFetch=false"
        
        AF.request(url).responseDecodable(of: [Chapter].self) { response in
            switch response.result {
            case .success(_):
                self.chapterList = response.value!
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}

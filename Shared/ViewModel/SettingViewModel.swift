//
//  SettingViewModel.swift
//  Koi
//
//  Created by Edgar Mejía on 26/12/21.
//

import Foundation

class SettingViewModel {
    
    func getAbout(completion: @escaping (Result<About?, Error>) -> ()) {
        guard let url = URL(string: "\(Tachidesk().getFullHost())\(Constants.API.TACHIDESK.SETTING)/about")
        else { return completion(.success(nil)) }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if data == nil { return completion(.success(nil)) }
            let about = try! JSONDecoder().decode(About.self, from: data!)
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(about))
                }
            }
        }
        .resume()
    }
    
}

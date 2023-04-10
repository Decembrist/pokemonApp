//
//  File.swift
//  Pokemons
//
//  Created by Андрей Павлов on 21.03.2023.
//

import Foundation
import Alamofire

final class ImageLoader {
    static let shared = ImageLoader()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    public func downloadImage(_ url: String, completion: @escaping (Result<Data, Error>)->Void) {
        let key = url as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            print("Cache image")
            return
        }

    

        
        AF.download(url).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                let resData = data as NSData
                self?.imageDataCache.setObject(resData, forKey: key)
                completion(.success(data))
            case .failure:
                completion(.failure(URLError(.badServerResponse)))
            }
        }
    }
}

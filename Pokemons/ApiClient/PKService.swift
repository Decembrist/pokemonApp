import UIKit
import Alamofire


final class PKService {
    public static let shared = PKService()
    
    private init() {}
    
    public func execute<T: Decodable>(
        _ request: PKRequest,
        excpecting type: T.Type,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        let cacher = ResponseCacher(behavior: .cache)
        AF.request("https://pokeapi.co/api/v2/type/")
            .cacheResponse(using: cacher)
            .responseDecodable(of: type.self) { response in
                
            switch response.result {
            case .success(let responseModel):
                completion(.success(responseModel))
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}

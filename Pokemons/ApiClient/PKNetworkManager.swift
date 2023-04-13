import Foundation
import Alamofire

final class PKNetworkManager {
    public static let shared = PKNetworkManager()
    
    private init() {}
    
    public func requestByModel<T: Decodable>(
        _ endpoint: String,
        excpecting type: T.Type,
        qos: DispatchQoS.QoSClass = .utility,
        completion: (@escaping (Result<T, Error>) -> Void)
    ) {
        let cacher = ResponseCacher(behavior: .cache)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(endpoint)
            .cacheResponse(using: cacher)
            .responseDecodable(of: type.self, queue: .global(qos: qos), decoder: decoder) { response in
                
            switch response.result {
            case .success(let responseModel):
                completion(.success(responseModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//
//  NetworkManager.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/22.
//

import Alamofire

final class NetworkManager {
    
    func get<T>(url: String,
                parameters: [String: Any]?,
                headers: [String: String]?,
                successHandler: ((T) -> Void)?,
                failureHandler: ((Error) -> Void)?)
    where T: Decodable {
        
        let headers: HTTPHeaders? = (headers != nil) ? HTTPHeaders(headers ?? [:]) : nil
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self, queue: globalQueue) { response in
                
                switch response.result {
                case .success(let model):
                    successHandler?(model)
                case .failure(let error):
                    failureHandler?(error)
                }
            }
    }
    
    //MARK: - Private
    private let globalQueue = DispatchQueue.global()
}

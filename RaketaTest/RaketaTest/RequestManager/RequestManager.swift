//
//  RequestManager.swift
//  RaketaTest
//
//  Created by mac on 28.01.2021.
//

import Foundation

class RequestManager {
    
    func loadTopItems(with limit: Int, after: String?, completion: @escaping (ResponseModel?, ResponseError?) -> ()) {
        let components = topPostsComponents(limit: limit, after: after)
        guard let url = components.url else {
            completion(nil, ResponseError.network(description: "Couldn't create request url"))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            guard let data = data else {
                let responseError = error != nil ? ResponseError.network(description: error!.localizedDescription) : nil
                completion(nil, responseError)
                return
            }
            do {
                let responseModel = try JSONDecoder().decode(ResponseModel.self, from: data)
                completion(responseModel, nil)
                return
            } catch {
                completion(nil, ResponseError.parsing(description: error.localizedDescription))
                return
            }
        }
        task.resume()
    }
}

private extension RequestManager {
    
    struct ApiSettings {
        static let scheme = "https"
        static let host = "reddit.com"
        static let path = "/top.json"
    }
    
    func topPostsComponents(limit: Int, after: String?) -> URLComponents {
        var components = URLComponents()
        components.scheme = ApiSettings.scheme
        components.host = ApiSettings.host
        components.path = ApiSettings.path
        
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        if after != nil {
            queryItems.append(URLQueryItem(name: "after", value: after!))
        }
        components.queryItems = queryItems
        return components
    }
}

//
//  RequestService.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


struct RequestService {
    
    // todo add model
    func loadData(urlString: String, session: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask? {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: "Wrong url format")))
            return nil
        }
        
        var request = RequestFactory.request(method: .GET, url: url)
        if let reachability = Reachability(), !reachability.isReachable { // check Network connection
            request.cachePolicy = .returnCacheDataDontLoad
        }
        let task = session.dataTask(with: request) { (data, response, error) in // fetching data
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}

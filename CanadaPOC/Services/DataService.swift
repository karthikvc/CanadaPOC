//
//  DataService.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol DataServiceProtocol : class {
    func fetchConverter(_ completion: @escaping ((Result<DataModel, ErrorResult>) -> Void))
}

final class DataService : RequestHandler, DataServiceProtocol {
    let endpoint = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var task : URLSessionTask?
    func fetchConverter(_ completion: @escaping ((Result<DataModel, ErrorResult>) -> Void)) {
        self.cancelFetchCurrencies()
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchCurrencies() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}

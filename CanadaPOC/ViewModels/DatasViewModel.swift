//
//  DatasViewModel.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class FeedsViewModel {
    weak var dataSource : GenericDataSource<ListModel>?
    var cellDidSelect: GenericDataSource<Int>?
    var title: String?
    var selectedData: ListModel?
    weak var service: DataServiceProtocol?
    
    init(service: DataServiceProtocol, dataSource : GenericDataSource<ListModel>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        service.fetchConverter { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    self.dataSource?.data.value = converter.rows
                    self.title = converter.title
                    completion?(Result.success(true))
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    completion?(Result.failure(error))
                    break
                }
            }
        }
    }
    
    func didSelectItemAt(indexPath: IndexPath){
        let feedsValue = dataSource?.data.value[indexPath.row]
        selectedData = feedsValue
    }
}

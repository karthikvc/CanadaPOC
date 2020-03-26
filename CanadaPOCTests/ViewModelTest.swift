//
//  ViewModelTest.swift
//  CanadaPOCTests
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import XCTest

@testable import CanadaPOC

class ViewModelTest: XCTestCase {
    
        fileprivate class MockDataService: DataServiceProtocol {
            var dataModel: DataModel?
            func fetchConverter(_ completion: @escaping ((Result<DataModel, ErrorResult>) -> Void)) {
                if let data = dataModel {
                    completion(Result.success(data))
                } else {
                    completion(Result.failure(ErrorResult.custom(string: "No converter")))
                }
            }
        }

        var viewModel : FeedsViewModel!
        var dataSource : GenericDataSource<ListModel>!
        fileprivate var service : MockDataService!
        
    override func setUp() {
        super.setUp()
        self.service = MockDataService()
        self.dataSource = GenericDataSource<ListModel>()
        self.viewModel = FeedsViewModel(service: service, dataSource: dataSource)
        
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }

    func testFetchDatas() {
        service.dataModel = DataModel(title: "Canada", rows: [])
        viewModel.fetchServiceCall{ result in
            switch result {
            case .failure(_) :
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            default: break
            }
        }
    }
    
    func testFetchNoDatas() {
        service.dataModel = nil
        viewModel.fetchServiceCall { result in
            switch result {
            case .success(_) :
                XCTAssert(false, "ViewModel should not be able to fetch ")
            default: break
            }
        }
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}


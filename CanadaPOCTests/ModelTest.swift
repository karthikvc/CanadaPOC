//
//  ModelTest.swift
//  CanadaPOCTests
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import XCTest
@testable import CanadaPOC

class ModelTest: XCTestCase {

    override func setUp() {
      
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testExampleEmptyCurrency() {
        let data = Data()
        let completion : ((Result<DataModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        ParserHelper.parse(data: data, completion: completion)
    }

    func testParseCurrency() {
        guard let data = FileManager.readJson(forResource: "facts") else {
            XCTAssert(false, "Can't get data from sample.json")
            return
        }
        let completion : ((Result<DataModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid converter")
            case .success(let converter):
                XCTAssertEqual(converter.title, "About Canada", "Expected About Canada base")
                XCTAssertEqual(converter.rows.count, 14, "Expected 14 rates")
            }
        }
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testWrongKeyCurrency() {
        let dictionary = ["testObject" : 123 as AnyObject]
        let result = DataModel.parseObject(dictionary: dictionary)
        switch result {
        case .success(_):
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }
}

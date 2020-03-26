//
//  DataModel.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


struct DataModel {
    let title : String
    let rows : [ListModel]
}

extension DataModel : Parceable {
    static func parseObject(dictionary: [String : AnyObject]) -> Result<DataModel, ErrorResult> {
        if let base = dictionary["title"] as? String,
            let rows = dictionary["rows"] as? [AnyObject] {
            var responseResults = [ListModel]()
            for properties in rows {
                let currentData = ListModel(dictionary: properties as! [String:Any])
                responseResults.append(currentData)
            }
            let conversion = DataModel(title: base, rows: responseResults)
            return Result.success(conversion)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}

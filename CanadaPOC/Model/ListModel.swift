//
//  ListModel.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


var util: Util { return Util() }

struct ListModel {
    let title: String!
    let description: String!
    let imageRef: String!
    
    init(dictionary: [String: Any]) {
        self.title = (util.filterNil(dictionary["title"] as AnyObject) as! String)
        self.description = (util.filterNil(dictionary["description"] as AnyObject) as! String)
        self.imageRef = util.filterNil(dictionary["imageHref"] as AnyObject) as? String
    }
}

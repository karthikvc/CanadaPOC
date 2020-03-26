//
//  Utility.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol Utility{
    func filterNil(_ value : AnyObject?) -> AnyObject?
}

class Util {
    
}

extension Util: Utility {
    func filterNil(_ value : AnyObject?) -> AnyObject? {
        if value is NSNull || value == nil {
            return "N/A" as AnyObject
        } else {
            return value
        }
    }
}

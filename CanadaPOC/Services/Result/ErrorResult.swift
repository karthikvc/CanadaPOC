//
//  ErrorResult.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}

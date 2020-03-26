//
//  Result.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

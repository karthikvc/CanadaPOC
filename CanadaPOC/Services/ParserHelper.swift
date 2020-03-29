//
//  ParserHelper.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


protocol Parceable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    // json decodable parser
    static func decode(data:Data) {
        
       
            let decoder = JSONDecoder()
            do {
                
                let stringToParse = String(decoding: data, as: UTF8.self)
                if let json = stringToParse.data(using: String.Encoding.utf8){
                    
                    let jsondata = try decoder.decode(CountryJsonModel.self, from: json)
                    //return jsondata
                    print(jsondata)
                }
                // parse is error
                return
                
            }
            catch {
                print(error)
                return 
            }
        
    }
    // json serialization parser
    static func parse<T: Parceable>(data: Data, completion : (Result<[T], ErrorResult>) -> Void) {
        
        do {
            
            if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
                // init final result
                var finalResult : [T] = []
                for object in result {
                    if let dictionary = object as? [String : AnyObject] {
                        // check foreach dictionary if parseable
                        switch T.parseObject(dictionary: dictionary) {
                        case .failure(_):
                            continue
                        case .success(let newModel):
                            finalResult.append(newModel)
                            break
                        }
                    }
                }
                
                completion(.success(finalResult))
                
            } else {
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
    static func parse<T: Parceable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        if let value = String(data: data, encoding: String.Encoding.ascii) {
            if let jsonData = value.data(using: String.Encoding.utf8) {
                do {
                    
                    decode(data: data)
                    
                    if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: AnyObject] {
                        print(dictionary)
                        // init final result
                        // check foreach dictionary if parseable
                        switch T.parseObject(dictionary: dictionary) {
                        case .failure(let error):
                            completion(.failure(error))
                            break
                        case .success(let newModel):
                            completion(.success(newModel))
                            break
                        }
                        
                    } else {
                        // not an array
                        completion(.failure(.parser(string: "Json data is not an array")))
                    }
                } catch {
                    // can't parse json
                    completion(.failure(.parser(string: "Error while parsing json data")))
                }
                
            }else{
                completion(.failure(.parser(string: "Error while parsing json data")))
            }
        }else{
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}

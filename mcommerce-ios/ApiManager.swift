//
//  ApiManager.swift
//  mcommerce-ios
//
//  Created by lukasz on 13.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Foundation
import Moya
import Mapper

class ApiManager {
    
    static let instance = ApiManager()
    
    // request for array responses
    func reqest<T: Mappable>(_ request: ApiService, completion: @escaping (_ response: T?) -> Void, errorCopletion: @escaping () -> Void) {
        let api = MoyaProvider<ApiService>()
        
        api.request(request) { result in
            switch result {
            case let .success(response):
                NSLog(String(data: response.data, encoding: .utf8)!)
                
                if (response.statusCode != 200) {
                    errorCopletion()
                }
                
                do {
                    let mappedResponse: T? = T.from(try response.mapJSON() as! NSDictionary)
                    
                    completion (mappedResponse)
                }
                catch {
                    NSLog("ERROR")
                    
                    errorCopletion()
                }
            case let .failure(error):
                NSLog(error.errorDescription!)
                
                errorCopletion()
            }
        }
    }
    
    // request for array responses
    func reqest<T: Mappable>(_ request: ApiService, completion: @escaping (_ response: [T]?) -> Void, errorCopletion: @escaping () -> Void) {
        let api = MoyaProvider<ApiService>()
        
        api.request(request) { result in
            switch result {
            case let .success(response):
                NSLog(String(data: response.data, encoding: .utf8)!)
                
                if (response.statusCode != 200) {
                    errorCopletion()
                }
                
                do {
                    let mappedResponse: [T]? = T.from(try response.mapJSON() as! NSArray)
                    
                    completion (mappedResponse)
                }
                catch {
                    NSLog("ERROR")
                    
                    errorCopletion()
                }
            case let .failure(error):
                NSLog(error.errorDescription!)
                
                errorCopletion()
            }
        }
    }
    
}

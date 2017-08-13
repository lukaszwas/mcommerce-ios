//
//  ApiService.swift
//  mcommerce-ios
//
//  Created by lukasz on 13.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Foundation
import Moya

enum ApiService {

    // categories
    case getAllCategories()
    case getRootCategories()
    case getSubategories(id: Int)

}

extension ApiService: TargetType {
    var baseURL: URL { return URL(string: "http://192.168.1.10:8080")! }
    var path: String {
        switch self {
        case .getAllCategories:
            return "/categories"
        case .getRootCategories:
            return "/categories/root"
        case .getSubategories(let id):
            return "/categories/\(id)/subcategories"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories:
            return nil
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories:
            return URLEncoding.default
        }
    }
    var sampleData: Data {
        return "test".utf8Encoded
    }
    var task: Task {
        return .request
    }
    var headers: [String: String]? {
        return
            [
                "Content-type": "application/json",
                "Authorization": "Bearer ACE2B1E3-627D-4A17-A5E2-7A83211FDF5B"
            ]
    }
}

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

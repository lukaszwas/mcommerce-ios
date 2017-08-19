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

    // products
    case getProductsWithCategoryId(categoryId: Int)
    case getProductsWithId(id: Int)
    case getRecommendedProducts()
    
}

extension ApiService: TargetType {
    var baseURL: URL { return URL(string: "http://192.168.1.11:8080")! }
    var path: String {
        switch self {
        case .getAllCategories:
            return "/categories"
        case .getRootCategories:
            return "/categories/root"
        case .getSubategories(let id):
            return "/categories/\(id)/subcategories"
        case .getProductsWithCategoryId(let id):
            return "/products/category/\(id)"
        case .getProductsWithId(let id):
            return "/products/\(id)"
        case .getRecommendedProducts:
            return "/products/recommended"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts:
            return nil
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts:
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
                "Authorization": "Bearer TOKEN"
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

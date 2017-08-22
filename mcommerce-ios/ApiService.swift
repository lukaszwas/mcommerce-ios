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

    // auth
    case login(email: String, password: String)
    case logout
    
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
    var baseURL: URL { return URL(string: "http://172.20.10.2:8080")! }
    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .logout:
            return "auth/logout"
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
        case .login, .logout:
            return .post
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts, .logout:
            return nil
        case .login(let email, let password):
            return ["email": email, "password": password]
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts:
            return URLEncoding.default
        case .login, .logout:
            return JSONEncoding.default
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

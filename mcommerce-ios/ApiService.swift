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
    case register(firstName: String, lastName: String, email: String, password: String)
    
    // categories
    case getAllCategories()
    case getRootCategories()
    case getSubategories(id: Int)

    // products
    case getProductsWithCategoryId(categoryId: Int)
    case getProductsWithId(id: Int)
    case getRecommendedProducts()
    case searchProducts(filter: String)
    
    // users
    case getUserWithId(id: Int)
    case saveUser(id: Int, firstName: String, lastName: String, email: String)
    
}

extension ApiService: TargetType {
    var baseURL: URL { return URL(string: "http://192.168.1.175:8081")! }
    var path: String {
        switch self {
            case .login:
                return "auth/login"
            case .logout:
                return "auth/logout"
            case .register:
                return "auth/register"
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
            case .searchProducts(let filter):
                return "/products/search/\(filter)"
            case .getUserWithId(let id):
                return "/users/\(id)"
            case .saveUser(let id, let _, let _, let _):
                return "/users/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts, .searchProducts, .getUserWithId:
                return .get
            case .login, .logout, .register:
                return .post
            case .saveUser:
                return .patch
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts, .logout, .searchProducts,.getUserWithId:
                return nil
            case .login(let email, let password):
                return ["email": email, "password": password]
            case .saveUser(let id, let firstName, let lastName, let email):
                return ["id": id, "firstName": firstName, "lastName": lastName, "email": email]
            case .register(let firstName, let lastName, let email, let password):
                return ["firstName": firstName, "lastName": lastName, "email": email, "password": password]
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts, .searchProducts, .getUserWithId:
                return URLEncoding.default
            case .login, .logout, .saveUser, .register:
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

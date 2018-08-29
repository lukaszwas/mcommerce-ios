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
    
    // purchase
    case purchase(userId: Int, statusId: Int, firstName: String, lastName: String, address1: String, address2: String, zipCode: String, city: String)
    case purchaseAddProduct(purchaseId: Int, productId: Int, price: Float)
    case getAllUserPurchases()
    case getPurchaseProducts(purchaseId: Int)
    case pay(purchaseId: Int, cardNumber: String, cardExpirationMonth: String, cardExpirationYear: String, cardCvc: String)
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
            case .purchase:
                return "/purchase"
            case .purchaseAddProduct:
                return "/purchase/addproduct"
            case .getAllUserPurchases:
                return "/purchase"
            case .getPurchaseProducts(let id):
                return "/purchase/\(id)"
            case .pay(let id, let _, let _, let _, let _):
                return "/purchase/pay/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts, .searchProducts, .getUserWithId, .getAllUserPurchases, .getPurchaseProducts:
                return .get
            case .login, .logout, .register, .purchase, .purchaseAddProduct, .pay:
                return .post
            case .saveUser:
                return .patch
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts, .logout, .searchProducts,.getUserWithId, .getAllUserPurchases, .getPurchaseProducts:
                return nil
            case .login(let email, let password):
                return ["email": email, "password": password]
            case .saveUser(let id, let firstName, let lastName, let email):
                return ["id": id, "firstName": firstName, "lastName": lastName, "email": email]
            case .register(let firstName, let lastName, let email, let password):
                return ["firstName": firstName, "lastName": lastName, "email": email, "password": password]
            case .purchase(let userId, let statusId, let firstName, let lastName, let address1, let address2, let zipCode, let city):
                return ["user_id": userId, "statusId": statusId, "first_name": firstName, "last_name": lastName, "address1": address1, "address2": address2, "zip_code": zipCode, "city": city]
            case .purchaseAddProduct(let purchaseId, let productId, let price):
                return ["purchase_id": purchaseId, "product_id": productId, "price": price]
            case .pay(let purchaseId, let cardNumber, let cardExpirationMonth, let cardExpirationYear, let cardCvc):
                return ["purchase_id": purchaseId, "card_number": cardNumber, "card_expiration_month": cardExpirationMonth, "card_expiration_year": cardExpirationYear, "card_cvc": cardCvc]
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAllCategories, .getRootCategories, .getSubategories, .getProductsWithCategoryId, .getProductsWithId, .getRecommendedProducts, .searchProducts, .getUserWithId, .getAllUserPurchases, .getPurchaseProducts:
                return URLEncoding.default
            case .login, .logout, .saveUser, .register, .purchase, .purchaseAddProduct, .pay:
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
        NSLog("TOKEN: %@", PersistanceManager.getUserToken())
        return
            [
                "Content-type": "application/json",
                "Authorization": "Bearer " + PersistanceManager.getUserToken()
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

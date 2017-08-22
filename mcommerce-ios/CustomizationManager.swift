//
//  CustomizationManager.swift
//  mcommerce-ios
//
//  Created by lukasz on 07.08.2017.
//  Copyright © 2017 lukasz. All rights reserved.
//

import Foundation
import UIKit

class CustomizationManager {
    static let instance = CustomizationManager()
    
    static func rgb(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(Double(red)/255.0), green: CGFloat(Double(green)/255.0), blue: CGFloat(Double(blue)/255.0), alpha: 1)
    }
    
    // Navigation controller
    static let navigationController_background = rgb(red: 240, green: 242, blue: 244)
    static let navigationController_textColor = rgb(red: 85, green: 119, blue: 147)
    static let navigationController_backText = "Powrót"
    
    // HOME -------------
    
    // Search bar
    static let home_searchBar_backgroundColor = rgb(red: 240, green: 242, blue: 244)
    static let home_searchBar_welcomeText = "Witaj!"
    static let home_searchBar_welcomeTextColor = rgb(red: 0, green: 0, blue: 0)
    static let home_searchBar_textField_borderColor = rgb(red: 168, green: 168, blue: 168)
    static let home_searchBar_textField_textColor = rgb(red: 168, green: 168, blue: 168)
    static let home_searchBar_textField_iconColor = rgb(red: 168, green: 168, blue: 168)
    static let home_searchBar_textField_text = "Czego szukasz?"
    
    // Tab bar
    static let home_tabBar_backgroundColor = rgb(red: 240, green: 242, blue: 244)
    static let home_tabBar_inactiveColor = rgb(red: 168, green: 168, blue: 168)
    static let home_tabBar_activeColor = rgb(red: 85, green: 119, blue: 147)
    static let home_tabBar_recommendedText = "Polecane"
    static let home_tabBar_categoriesText = "Kategorie"
    static let home_tabBar_cartText = "Koszyk"
    static let home_tabBar_moreText = "Więcej"
    
    // Recommended
    static let recommended_headerColor = rgb(red: 85, green: 119, blue: 147)
    static let recommended_emptyList_imageColor = rgb(red: 168, green: 168, blue: 168)
    static let recommended_emptyList_textColor = rgb(red: 168, green: 168, blue: 168)
    static let recommended_emptyList_text = "Brak polecanych produktów"
    
    // Categories
    static let categories_backgroundColor = rgb(red: 255, green: 255, blue: 255)
    static let categories_borderColor = rgb(red: 240, green: 242, blue: 244)
    static let categories_iconColor = rgb(red: 85, green: 119, blue: 147)
    static let categories_textColor = rgb(red: 0, green: 0, blue: 0)
    static let categories_allCategoriesText = "Wszystkie kategorie"
    static let categories_allProductsText = "Wszystko: "
    
    // Cart
    static let cart_login_buttonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let cart_login_labelText = "Zaloguj się, aby zobaczyć swój koszyk"
    static let cart_login_buttonText = "Zaloguj się"
    static let cart_empty_imageColor = rgb(red: 85, green: 119, blue: 147)
    static let cart_empty_labelText = "Twój koszyk jest pusty!"
    static let cart_products_borderColor = rgb(red: 240, green: 242, blue: 244)
    static let cart_products_textFieldBorderColor = rgb(red: 168, green: 168, blue: 168)
    static let cart_products_quantityText = "Ilość"
    static let cart_products_deleteText = "Usuń"
    static let cart_products_sumTitleText = "Łączna kwota"
    static let cart_products_buyButtonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let cart_products_buyButtonText = "Do kasy"
    
    // More
    static let more_login_buttonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let more_login_loginText = "Zaloguj się, aby zobaczyć więcej opcji"
    static let more_login_loginButtonText = "Zaloguj się"
    static let more_menu_iconsColor = rgb(red: 85, green: 119, blue: 147)
    static let more_menu_borderColor = rgb(red: 240, green: 242, blue: 244)
    static let more_menu_ordersText = "Historia zamówień"
    static let more_menu_userDataText = "Twoje dane"
    static let more_menu_logoutText = "Wyloguj się"
    
    // PRODUCTS ------------
    
    static let products_currencyText = " zł"
    
    // Products list
    static let products_list_borderColor = rgb(red: 240, green: 242, blue: 244)
    static let products_emptyList_imageColor = rgb(red: 168, green: 168, blue: 168)
    static let products_emptyList_textColor = rgb(red: 168, green: 168, blue: 168)
    static let products_emptyList_text = "Brak produktów"
    
    // Product details
    static let productsDetails_borderColor = rgb(red: 240, green: 242, blue: 244)
    static let productsDetails_addToCart_backgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let productsDetails_rateStar_activeBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let productsDetails_rateStar_inactiveBackgroundColor = rgb(red: 240, green: 242, blue: 244)
    static let productsDetails_addToCartText = "Produkt został dodany do koszyka"
    static let productsDetails_noImageColor = rgb(red: 85, green: 119, blue: 147)
    
    // AUTH
    
    // Login
    static let auth_login_title = "Logowanie"
    static let auth_login_buttonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let auth_login_borderColor = rgb(red: 168, green: 168, blue: 168)
    static let auth_login_emailText = "Adres e-mail"
    static let auth_login_passwordText = "Hasło"
    static let auth_login_buttonLoginText = "Zaloguj się"
    static let auth_login_registerQuestionText = "Nie masz jeszcze konta?"
    static let auth_login_registerText = "Zarejestruj się"
    static let auth_login_emptyFieldsText = "Wypełnij wszystkie pola"
    static let auth_login_incorrectDataText = "Podane dane są niepoprawne"
    
    // Register
    static let auth_register_title = "Rejestracja"
    static let auth_register_borderColor = rgb(red: 168, green: 168, blue: 168)
    static let auth_register_buttonBackgroundColor = rgb(red: 85, green: 119, blue: 147)
    static let auth_register_firstNameText = "Imię"
    static let auth_register_lastNameText = "Nazwisko"
    static let auth_register_emailText = "Adres e-mail"
    static let auth_register_passwordText = "Hasło"
    static let auth_register_repeatPasswordText = "Powtórz hasło"
    static let auth_register_registerButtonText = "Zarejestruj się"
    static let auth_register_emptyFieldsText = "Wypełnij wszystkie pola"
    
}

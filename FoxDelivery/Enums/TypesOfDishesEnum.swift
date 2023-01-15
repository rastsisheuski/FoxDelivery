//
//  TypesOfDishesEnum.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 14.01.23.
//

import UIKit

enum TypesOfDishesEnum: String, CaseIterable {
    case kishes = "kishes"
    case soups = "soups"
    case burgers = "burgers"
    case desserts = "desserts"
    case sauces = "sauces"
    case drinks = "drinks"
    
    var russianTranslate: String {
        switch self {
            case .kishes:   return "Киши"
            case .soups:    return "Супы"
            case .burgers:  return "Бургеры"
            case .desserts: return "Десерты"
            case .sauces:   return "Соусы"
            case .drinks:   return "Напитки"
        }
    }
}

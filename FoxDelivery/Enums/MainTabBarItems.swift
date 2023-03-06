//
//  MainTabBarItems.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 11.02.23.
//

import UIKit

enum MainTabBarItems {
    case menu
    case basket
    case profile
    
    var name: String {
        switch self {
            case .menu:
                return "Меню"
            case .basket:
                return "Корзина"
            case .profile:
                return "Профиль"
        }
    }
    
    var image: UIImage {
        switch self {
            case .menu:
                return Icons.mainIcon.image
            case .basket:
                return Icons.basketIcon.image
            case .profile:
                return Icons.profileIcon.image
        }
    }
}

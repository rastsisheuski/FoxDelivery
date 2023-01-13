//
//  DeliveryMenuMainTabBarDependencyContainer.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 2.01.23.
//

import UIKit

class DeliveryMenuMainTabBarDependencyContainer {
    
    func makeMainTabBarController() -> UITabBarController {
        
//        let dishesViewController = {
//            self.createDishesViewController()
//        }
//
//        let basketViewController = {
//            self.createBasketViewController()
//        }
        
        let tabBar = UITabBarController()
        let appearance = UITabBarAppearance()
        tabBar.tabBar.clipsToBounds = true
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundImage = Images.tabBarBackgroundImage.image
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: Colors.General.selectedButton]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.iconColor = Colors.General.selectedButton
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
//        tabBar.viewControllers = [dishesViewController(), basketViewController()]
        return tabBar
    }
    
//    private func createDishesViewController() -> DishesViewController {
//        return DishesViewController()
//    }
    
//    private func createBasketViewController() -> BasketViewController {
//        return BasketViewController()
//    }
}


//
//  DishesViewController.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 10.01.23.
//

import Foundation

class DishesViewController: NiblessViewController {
    var contentView: DishesViewControllerView {
        view as! DishesViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        
        view = DishesViewControllerView()
    }
}

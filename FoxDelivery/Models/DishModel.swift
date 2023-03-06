//
//  DishModel.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 30.01.23.
//

import UIKit

struct DishModel {
    var name: String
    var type: TypesOfDishesEnum
    var weightOrVolume: String
    var price: Int
    var id: String
    var url: String
    
    init(name: String, type: TypesOfDishesEnum, weightOrVolume: String, price: Int, id: String, url: String) {
        self.name = name
        self.type = type
        self.weightOrVolume = weightOrVolume
        self.price = price
        self.id = id
        self.url = url
    }
}

//
//  BasketViewModel.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 23.02.23.
//

import Foundation

class BasketViewModel {
    let currentBasketDishModels: Dynamic<[DishModel]> = Dynamic([])
    let currentBasketDishes: Dynamic<[[String : Int]]> = Dynamic([[:]])
    let loading: Dynamic<Bool?> = Dynamic(false)
    let error: Dynamic<String?> = Dynamic(nil)
    
    private let apiManager: APIManager
    private var arrayOfDishes = [DishModel]()
    private let dispatchGroup = DispatchGroup()
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func getActualBasketDishesForCurrentUser() {
        apiManager.getActualBasketDishesForCurrentUser { basketDishes in
            self.currentBasketDishes.value = basketDishes
        } failure: {
            self.error.value = "Can't getting current basket dishes"
        }
    }
    
    func getDishModelsFromBasketDishes(currentBasketDishes: [[String : Int]]) {
        loading.value = true
        
        var resultArray = [DishModel]()
        
        for type in TypesOfDishesEnum.allCases {
            dispatchGroup.enter()
            apiManager.getDishes(collection: type) { [weak self] result in
                guard let result else { return }
                guard let self else { return }
                
                resultArray += result
                self.dispatchGroup.leave()
                
            } failure: {
                self.error.value = "Can't downloading info abount dishes"
                self.dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.arrayOfDishes = resultArray.sorted(by: { $0.name < $1.name })
            var arrayToReturn: [DishModel] = []
            for dishModel in self.arrayOfDishes {
                for basketDish in currentBasketDishes {
                    if dishModel.id == basketDish.keys.first {
                        arrayToReturn.append(dishModel)
                    }
                }
            }
            self.currentBasketDishModels.value = arrayToReturn
            self.loading.value = false
        }
    }
    
    func deleteFromBasket(dishInfo: [String : Int]) {
        apiManager.deleteDishFromBasket(dishInfo: dishInfo) {
            
        }
    }
}

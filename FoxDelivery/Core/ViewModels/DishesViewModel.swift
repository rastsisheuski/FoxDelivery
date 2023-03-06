//
//  DishesViewModel.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 30.01.23.
//

import Foundation

class DishesViewModel {
    let loading: Dynamic<Bool?> = Dynamic(false)
    let error: Dynamic<String?> = Dynamic(nil)
    let selectedDishesArray: Dynamic<[DishModel]> = Dynamic([])
    let currentBasket: Dynamic<[[String : Int]]> = Dynamic([[:]])
    let apiManager: APIManager
    
    private var arrayOfDishes = [DishModel]()
    private let dispatchGroup = DispatchGroup()
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func getDataFromDataBase() {
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
            self.filterArrayOfDishes(by: 0)
            self.loading.value = false
        }
    }
    
    func getActualBasketDishesForCurrentUser() {
        apiManager.getActualBasketDishesForCurrentUser { basketDishes in
            self.currentBasket.value = basketDishes
        } failure: {
            self.error.value = "Can't getting current basket dishes"
        }
    }
    
    func filterArrayOfDishes(by index: Int) {
        let type = TypesOfDishesEnum.allCases[index]
        let filterArray = arrayOfDishes.filter{ $0.type.rawValue == type.rawValue }

        selectedDishesArray.value = filterArray
    }
    
    private func addDishToBasket(id: String) {
        apiManager.addDishToBasket(id: id) {
            
        }
    }
    
    private func removeDishFromBasket(id: String) {
        apiManager.removeDishFromBasket(id: id) {
            
        }
    }
}

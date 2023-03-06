//
//  APIManager.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 2.01.23.
//

import Foundation

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {
    
    // MARK: -
    // MARK: - Private Methods
    
    private func configureFirebase() -> Firestore {
        var dataBase: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        dataBase = Firestore.firestore()
        return dataBase
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func setUserData(currentUser: UserModel, completion: @escaping (Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let dataBase = configureFirebase()
//        dataBase.collection("Users").document(userUID).collection("UserOrdersHistory").addDocument(data: [
        
        dataBase.collection("Users").document(userUID).setData([
            "name" : currentUser.name,
            "email" : currentUser.email,
            "phone" : currentUser.phoneNumber,
            "basket" : currentUser.currentBasket
        ]){ error in
            completion(error)
        }
    }
    
    func getDishes(collection: TypesOfDishesEnum, completion: @escaping ([DishModel]?) -> Void, failure: @escaping () -> Void) {
        let dataBase = configureFirebase()
        dataBase.collection(collection.rawValue).getDocuments { result, error in
            guard let result else { return }
            
            if let error = error {
                print(error.localizedDescription)
                failure()
            } else {
                var arrayToReturn = [DishModel]()
                
                for doc in result.documents {
                    let data = doc.data()
                    guard let nameField = data["nameField"] as? String else { return }
                    guard let volumeFiled = data["volumeField"] as? String else { return }
                    guard let priceField = data["priceField"] as? Int else { return }
                    guard let id = data["id"] as? String else { return }
                    guard let url = data["imageURL"] as? String else { return }

                    let dishModel = DishModel(name: nameField, type: collection, weightOrVolume: volumeFiled, price: priceField, id: id, url: url)
                    arrayToReturn.append(dishModel)
                }
                completion(arrayToReturn)
            }
        }
    }
    
    func getImageURL(folderName: String, picName: String, completion: @escaping (URL?) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathReference = reference.child("pictures/" + "\(folderName)/")
        
        let imageRef = pathReference.child(picName + ".png")
        imageRef.downloadURL { url, error in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(url)
        }
    }
    
    // MARK: -
    // MARK: - Basket Methods
    
    func addDishToBasket(id: String, completion: @escaping ()-> Void) {
        let dataBase = configureFirebase()
        let standardPitch = 1
        var selectedDishInfo: [String : Int] = [:]
        
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        getSelectedDishFromCurrentBasket(id: id) { currentDishInfo in
            guard let currentDishInfo else {
                let dishInfo = [[id : standardPitch]] as? [[String : Int]]
                
                dataBase.collection("Users").document(userUID).updateData([
                    "currentBasket" : FieldValue.arrayUnion(dishInfo!)
                ])
                return
            }
            selectedDishInfo = currentDishInfo
        }
                    
        guard let storedAmount = selectedDishInfo.values.first else { return }
        
        let currentAmount = storedAmount - standardPitch
        let dishInfo = [[id : currentAmount]] as? [[String : Int]]
        
        dataBase.collection("Users").document(userUID).updateData([
            "currentBasket" : FieldValue.arrayUnion(dishInfo!)
        ]) { error in
            completion()
        }
    }
    
    func removeDishFromBasket(id: String, completion: @escaping ()-> Void) {
        let dataBase = configureFirebase()
        let standardPitch = 1
        var selectedDishInfo: [String : Int] = [:]
        getSelectedDishFromCurrentBasket(id: id) { currentDishInfo in
            guard let currentDishInfo else { return }
            
            selectedDishInfo = currentDishInfo
            
            guard let userUID = Auth.auth().currentUser?.uid else { return }
            guard let storedAmount = selectedDishInfo.values.first else { return }
            
            let currentAmount = storedAmount - standardPitch
            if  currentAmount == 0 {
                self.deleteDishFromBasket(dishInfo: selectedDishInfo, completion: completion)
            } else {
                let dishInfo = [[id : currentAmount]] as? [[String : Int]]
                
                dataBase.collection("Users").document(userUID).updateData([
                    "currentBasket" : FieldValue.arrayUnion(dishInfo!)
                ])
            }
        }
    }
    
    func deleteDishFromBasket(dishInfo: [String : Int], completion: @escaping ()-> Void) {
        let dataBase = configureFirebase()
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        dataBase.collection("Users").document(userUID).updateData([
            "currentBasket" : FieldValue.arrayRemove([dishInfo])
        ]) { error in
            completion()
        }
    }
    
    func getSelectedDishFromCurrentBasket(id: String, completion: @escaping ([String : Int]?) -> Void) {
        let dataBase = configureFirebase()
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        var dishInfoToReturn: [String : Int]? = nil
        
        dataBase.collection("Users").document(userUID).getDocument { snapshot, error in
            guard let snapshot else { return }
            guard let data = snapshot.data() else { return }
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else {
                guard let dishesInfo = data["currentBasket"] as? [[String : Int]] else { return }
                dishesInfo.forEach { dishInfo in
                    if dishInfo.keys.first == id {
                        dishInfoToReturn = dishInfo
                    }
                }
            }
            completion(dishInfoToReturn)
        }
    }
    
    func getActualBasketDishesForCurrentUser(completion: @escaping ([[String : Int]]) -> Void, failure: @escaping () -> Void) {
        let dataBase = configureFirebase()
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        dataBase.collection("Users").document(userUID).getDocument { (snapshot, error) in
            guard let snapshot else { return }
            
            if let error = error {
                print("Error of getting basket dishes data: \(error.localizedDescription)")
                failure()
            } else {
                var arrayToReturn = [[String : Int]]()
                let data = snapshot.data()
                guard let basketArray = data?["currentBasket"] as? [[String : Int]] else { return }
                
                arrayToReturn = basketArray
                
                completion(arrayToReturn)
            }
        }
    }
}

//
//  RegistrationViewModel.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 4.01.23.
//

import Foundation

class RegistrationViewModel {
    
    let registrationComplite: Dynamic<Error?> = Dynamic(nil)
    
    private let authManager: AuthManager
    private let apiManager: APIManager
    
    init(authManager: AuthManager, apiManager: APIManager) {
        self.authManager = authManager
        self.apiManager = apiManager
    }
    
    func registrationUser(userModel: UserModel) {
        authManager.createUser(user: userModel) { [weak self] result in
            switch result {
                case .success(_):
                    self?.setUserData(userModel: userModel)
                    // TODO: - делегатом  dismiss экран
                case .failure(let error):
                    self?.registrationComplite.value = error
            }
        }
    }
    
    private func setUserData(userModel: UserModel) {
        apiManager.setUserData(currentUser: userModel) { [weak self] error in
            self?.registrationComplite.value = error
        }
    }
}

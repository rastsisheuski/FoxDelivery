//
//  LoginViewModel.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 2.01.23.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    let signInResponce: Dynamic<Error?> = Dynamic(nil)
    
    private let authManager: AuthManager
    private let apiManager: APIManager
    
    init(authManager: AuthManager, apiManager: APIManager) {
        self.authManager = authManager
        self.apiManager = apiManager
    }
    
    func signIn(loginUser: LoginUserModel) {
        authManager.signIn(loginUser: loginUser) { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(_):
                    self.signInResponce.value = nil
                    // TODO: - делегатом  dismiss экран
                case .failure(let error):
                    self.signInResponce.value = error
                    
            }
        }
    }
    
    func setUserData(currentUser: UserModel) {
        apiManager.setUserData(currentUser: currentUser) { [weak self] error in
            guard let self else { return }
            if error == nil {
                self.signInResponce.value = nil
            } else {
                self.signInResponce.value = error
            }
        }
    }
}

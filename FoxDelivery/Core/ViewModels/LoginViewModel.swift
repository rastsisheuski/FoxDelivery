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
    private let auth = Auth.auth()
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func signIn(loginUser: LoginUserModel) {
        authManager.signIn(loginUser: loginUser) { [weak self] result in
            switch result {
                case .success(_):
                    self?.signInResponce.value = nil
                    // TODO: - делегатом  dismiss экран
                case .failure(let error):
                    self?.signInResponce.value = error
            }
        }
    }
}

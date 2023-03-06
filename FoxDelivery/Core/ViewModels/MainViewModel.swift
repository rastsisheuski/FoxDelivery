//
//  MainViewModel.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 2.01.23.
//

import UIKit
import Firebase

class MainViewModel {
    let mainView: Dynamic<MainView?> = Dynamic(nil)
    let stepBack: Dynamic<Void> = Dynamic(Void())
    
    func checkAuthorization() {
        
//        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
//            guard let self else { return }
//            if user != nil {
//                self.mainView.value = .mainTabBar
//            } else {
//                self.mainView.value = .login
//            }
//        }
        
        self.mainView.value = .mainTabBar
    }
}

extension MainViewModel: MainResponder {
    func mainTabBar() {
        mainView.value = .mainTabBar
    }
    
    func showLogin() {
        mainView.value = .login
    }
    
    func showRegistration() {
        mainView.value = .registration
    }
}

extension MainViewModel: NavigationStepBackResponder {
    func handleStepBack() {
        stepBack.value = Void()
    }
}

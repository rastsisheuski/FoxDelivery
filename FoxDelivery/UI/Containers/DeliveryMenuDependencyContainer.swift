//
//  DeliveryMenuDependencyContainer.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 2.01.23.
//

import UIKit

class DeliveryMenuDepentencyContainer {
    
    func makeMainViewController() -> MainViewController {
        
        let sharedViewModel = createMainViewModel()
        let sharedAuthManager = createAuthManager()
        let sharedAPIManager = createAPIManager()
        
        let loginViewControllerFactory = {
            self.makeLoginViewController(navigationRespnoder: sharedViewModel, authManager: sharedAuthManager)
        }
        
        let registrationViewControllerFactory = {
            self.makeRegistrationViewController(authManager: sharedAuthManager, apiManager: sharedAPIManager, navigationStepBackResponder: sharedViewModel)
        }
        
        let mainTabBarControllerFactory = {
            self.makeMainTabBarControllerFactory()
        }
        
        return MainViewController(viewModel: sharedViewModel, loginViewControllerFactory: loginViewControllerFactory, registrationViewControllerFactory: registrationViewControllerFactory, mainTabBarControllerFactory: mainTabBarControllerFactory)
    }
    
    private func makeLoginViewController(navigationRespnoder: MainResponder, authManager: AuthManager) -> LoginViewController {
        let viewModel = makeLoginViewModel(authManager: authManager)
        return LoginViewController(viewModel: viewModel, navigationResponer: navigationRespnoder)
    }
    
    private func makeLoginViewModel(authManager: AuthManager) -> LoginViewModel {
        return LoginViewModel(authManager: authManager)
    }
    
    private func makeRegistrationViewController(authManager: AuthManager, apiManager: APIManager,  navigationStepBackResponder: NavigationStepBackResponder) -> RegistrationViewController {
        let viewModel = makeRegistrationViewModel(authManager: authManager, apiManager: apiManager)
        return RegistrationViewController(viewModel: viewModel, navigationStepBackResponder: navigationStepBackResponder)
    }
    
    private func makeRegistrationViewModel(authManager: AuthManager, apiManager: APIManager) -> RegistrationViewModel {
        return RegistrationViewModel(authManager: authManager, apiManager: apiManager)
    }
    
    private func makeMainTabBarControllerFactory() -> UITabBarController {
        DeliveryMenuMainTabBarDependencyContainer().makeMainTabBarController()
    }
    
    private func createMainViewModel() -> MainViewModel {
        return MainViewModel()
    }
    
    private func createAuthManager() -> AuthManager {
        return AuthManager()
    }
    
    private func createAPIManager() -> APIManager {
        return APIManager()
    }
}


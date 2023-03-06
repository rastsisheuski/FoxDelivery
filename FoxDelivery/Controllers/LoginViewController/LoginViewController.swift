//
//  LoginViewController.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 2.01.23.
//

import Foundation

class LoginViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Private Properties
    
    private var contentView: LoginViewControllerView {
        view as! LoginViewControllerView
    }
    
    // MARK: -
    // MARK: - Public Properties
    
    let viewModel: LoginViewModel
    let navigationResponer: MainResponder
    
    // MARK: -
    // MARK: - LifeCycle
    
    init(viewModel: LoginViewModel, navigationResponer: MainResponder) {
        self.viewModel = viewModel
        self.navigationResponer = navigationResponer
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        view = LoginViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupTargets()
        bindViewModel()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func bindViewModel() {
        viewModel.signInResponce.bind { [weak self] error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            self?.navigationResponer.mainTabBar()
        }
    }
    
    private func setupTargets() {
        contentView.bottomView.enterButton.addTarget(self, action: #selector(wasEnterButtonTapped), for: .touchUpInside)
        contentView.bottomView.registrationButton.addTarget(self, action: #selector(registrationButtonWasPressed), for: .touchUpInside)
    }
    
    private func createLoginUser() -> LoginUserModel? {
        let emailField = contentView.bottomView.emailView.textField
        let passwordField = contentView.bottomView.passwordView.textField
        
        guard let email = emailField.text, emailField.isValid,
              let password = passwordField.text, passwordField.isValid else { return nil }
        
        let loginUser = LoginUserModel(email: email, password: password)
        return loginUser
    }
}

// MARK: -
// MARK: - Extension LoginViewController + @Objc Methods

extension LoginViewController {
    @objc private func wasEnterButtonTapped() {
        contentView.bottomView.checkValidateState()
        guard let loginUser = createLoginUser() else { return }
        viewModel.signIn(loginUser: loginUser)
    }
    
    @objc private func registrationButtonWasPressed() {
        navigationResponer.showRegistration()
    }
}

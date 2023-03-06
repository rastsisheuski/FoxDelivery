//
//  RegistrationViewController.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 2.01.23.
//

import UIKit

class RegistrationViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Private Properties
    
    private var contentView: RegistrationViewControllerView {
        view as! RegistrationViewControllerView
    }
    
    // MARK: -
    // MARK: - Public Properties
    
    let navigationStepBackResponder: NavigationStepBackResponder
    let viewModel: RegistrationViewModel
    
    // MARK: -
    // MARK: - LifeCycle
    
    init(viewModel: RegistrationViewModel ,navigationStepBackResponder: NavigationStepBackResponder) {
        self.viewModel = viewModel
        self.navigationStepBackResponder = navigationStepBackResponder
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        view = RegistrationViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupTargets()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func bindViewModel() {
        viewModel.registrationComplite.bind { [weak self] error in
            guard let self else { return }
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self.navigationStepBackResponder.handleStepBack()
        }
    }
    
    private func setupTargets() {
        contentView.bottomView.registrationButton.addTarget(self, action: #selector(confirmButtonWasPressed), for: .touchUpInside)
        contentView.backButton.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
    }
    
    private func createUserModel() -> UserModel? {
        let nameTextField = contentView.bottomView.nameView.textField
        let phoneTextField = contentView.bottomView.phoneView.textField
        let emailTextField = contentView.bottomView.emailView.textField
        let passwordTextField = contentView.bottomView.passwordView.textField
        
        guard let name = nameTextField.text, nameTextField.isValid,
              let phone = phoneTextField.text, phoneTextField.isValid,
              let email = emailTextField.text, emailTextField.isValid,
              let password = passwordTextField.text, passwordTextField.isValid else { return nil }
        
        let currentUser = UserModel(
            name: name,
            email: email,
            phoneNumber: phone,
            password: password)
        
        return currentUser
    }
}

// MARK: -
// MARK: - Extension RegistrationViewController + @Objc Methods

extension RegistrationViewController {
    @objc private func confirmButtonWasPressed() {
        contentView.bottomView.checkisValidFields()
        
        guard let user = createUserModel() else { return }
        viewModel.registrationUser(userModel: user)
//        viewModel.setUserData(currentUser: loginUser)
    }
            
    @objc private func backButtonWasPressed() {
        navigationStepBackResponder.handleStepBack()
    }
}


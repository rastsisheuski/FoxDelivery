//
//  Constants.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 2.01.23.
//

import Foundation

enum Constants {
    enum TabBar {
        static let tbBarHegiht: CGFloat = 83
    }
    
    enum InputView {
        static let textFieldHeight: CGFloat = 50
        static let textFieldFontSize: CGFloat = 15
        static let titleFoncSize: CGFloat = 25
        static let fieldLeftViewWidth: CGFloat = 15
        static let mainButtonsHeight: CGFloat = 70
    }
    
    enum AuthTextField {
        static let textFieldVerticalPadding: CGFloat = 16
        static let textFieldHorizontalPadding: CGFloat = 16
        static let placeholderFontSize: CGFloat = 16
        static let errorLabelFontSize: CGFloat = 10
        static let animationTime: Double = 0.5
    }
    
    enum RegistrationBottomView {
        static let checkBoxHeight: CGFloat = 32
        static let privacyPolicyStringFontSize: CGFloat = 12
        static let confirmButtonVerticalPadding: CGFloat = 20
        static let confirmButtonHorizontalPadding: CGFloat = 20
        static let confirmButtonFontSize: CGFloat = 20
        static let titleFontSize: CGFloat = 25
    }
    
    enum LoginBottomView {
        static let titleFontSize: CGFloat = 25
        static let forgotPasswordFontSize: CGFloat = 10
        static let registrationAccountFontSize: CGFloat = 13
        static let backButtonHeight: CGFloat = 32
    }
    
    enum TimerInterval {
        static let interval: Double = 1.5
    }
    
    enum TypesOfDishesView {
        static let separatorLeadingConstraint: CGFloat = 16
        static let separatorTrailingConstraint: CGFloat = 16
        static let separatorTopConstraint: CGFloat = 16
        static let separatorHeightConstraint: CGFloat = 0.5
    }
    
    enum TypesOfDishesCollectionViewCell {
        static let containerCornerRadius: CGFloat = 12
        static let dishLabelFontSize: CGFloat = 13
        static let containerViewTopConstraint: CGFloat = 5
        static let containerViewBottomConstraint: CGFloat = 5
    }
    
    enum DishesViewControllerView {
        static let titleLabelFontSize: CGFloat = 25
        static let baseTitleLabelConstraint: CGFloat = 16
        static let typesOfDishesViewHeight: CGFloat = 60
        static let typesOfDishesViewTopConstraint: CGFloat = 16
    }
}

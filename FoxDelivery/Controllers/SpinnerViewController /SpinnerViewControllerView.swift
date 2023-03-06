//
//  SpinnerViewControllerView.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 9.01.23.
//

import UIKit

class SpinnerViewControllerView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = Colors.General.selectedButton
        spinner.style = .large
        return spinner
    }()
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupView()
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func layoutElements() {
        layoutActivityIndicator()
    }
    
    private func setupView() {
        backgroundColor = Colors.SpinnerView.mainColorWithAlpha
        
    }
    
    private func layoutActivityIndicator() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

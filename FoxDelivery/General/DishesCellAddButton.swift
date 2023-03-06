//
//  DishesCellAddButton.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 15.01.23.
//

enum DishesCellAddButtonState {
    case active
    case disactive
}

import UIKit

class DishesCellAddButton: UIButton {
    
    // MARK: -
    // MARK: - Public Properties
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isUserInteractionEnabled = true
        stackView.spacing = 5
        return stackView
    }()
    
    let addLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Добавить"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.isUserInteractionEnabled = true
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "basket")
        imageView.tintColor = Colors.General.blackColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    var currentState: DishesCellAddButtonState {
        didSet {
            switch currentState {
                case .active:
                    setActiveState()
                case .disactive:
                    setDisactiveState()
            }
        }
    }
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(frame: CGRect, currentState: DishesCellAddButtonState) {
        self.currentState = currentState
        super.init(frame: frame)
        
        layoutStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Override Methods
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for _ in subviews {
            return self
        }
        return nil
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func layoutStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        stackView.addArrangedSubview(buttonImageView)
        stackView.addArrangedSubview(addLabel)
    }
    
    private func setActiveState() {
        addLabel.text = "Добавлено"
        backgroundColor = Colors.General.selectedButton
    }
    
    private func setDisactiveState() {
        addLabel.text = "Добавить"
        backgroundColor = Colors.General.unSelectedButton
    }
    
    func changeButtonState() {
        switch currentState {
        case .active:
            currentState = .disactive
        case .disactive:
            currentState = .active
        }
    }
}

// MARK: -
// MARK: - Extension DishesCellAddButton + @objc Methods

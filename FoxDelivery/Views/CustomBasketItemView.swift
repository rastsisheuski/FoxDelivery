//
//  CustomBasketItemView.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 16.02.23.
//

import UIKit

class CustomBasketItemView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.defaultDishImage.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.General.whiteColor
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Colors.General.lightGrayColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.General.lightGrayColor
        return view
    }()
    
    let counterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = Colors.General.whiteColor
        button.tag = 0
        button.addTarget(CustomBasketItemView.self, action: #selector(didChangeCountButtonTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = Colors.General.whiteColor
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = Colors.General.whiteColor
        button.tag = 1
        button.addTarget(CustomBasketItemView.self, action: #selector(didChangeCountButtonTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = Colors.General.whiteColor
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var selectedModel: DishModel?
    private var counter: Int = 1
    private var firstAppear = true
    private var defaultDishAmount = 1
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Public Methods

    func set(selectedModel: DishModel) {
        self.selectedModel = selectedModel
        
        let price = selectedModel.price
        nameLabel.text = selectedModel.name
        descriptionLabel.text = selectedModel.weightOrVolume
        counterLabel.text = "\(defaultDishAmount)"
        amountLabel.text = "\(price) ₽."
        imageView.sd_setImage(with: URL(string: selectedModel.url), placeholderImage: Icons.defaultDishIcon.image)
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = Colors.basketItemView.backgroundColor
        layer.cornerRadius = 30
        clipsToBounds = true
    }
    
    private func countAmount() {
        guard let selectedModel else { return }
        let totalAmount = selectedModel.price * counter
        amountLabel.text = "\(totalAmount) ₽."
    }
    
    private func layoutElements() {
        layoutImageView()
        layoutNameLabel()
        layoutDescriptionLabel()
        layoutSeparatorView()
        layoutCounterStackView()
        layoutAmountLabel()
    }
    
    private func layoutImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.General.defaultSpacing),
            imageView.widthAnchor.constraint(equalToConstant: Constants.CustomBasketItemView.imageWidth),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    private func layoutNameLabel() {
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.General.defaultSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.General.defaultSpacing),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutDescriptionLabel() {
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.General.defaultSpacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constants.General.defaultSpacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutSeparatorView() {
        addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.General.defaultSpacing),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func layoutCounterStackView() {
        counterStackView.addArrangedSubview(minusButton)
        counterStackView.addArrangedSubview(counterLabel)
        counterStackView.addArrangedSubview(plusButton)
        addSubview(counterStackView)
        
        NSLayoutConstraint.activate([
            counterStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            counterStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Constants.General.defaultSpacing),
            counterStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutAmountLabel() {
        addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Constants.General.defaultSpacing),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            amountLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
}

extension CustomBasketItemView {
    @objc func didChangeCountButtonTap(sender: UIButton) {
        switch sender.tag {
            case 0:
                if counter > 1 {
                    counter -= 1
                    counterLabel.text = "\(counter)"
                    countAmount()
                }
            case 1:
                counter += 1
                counterLabel.text = "\(counter)"
                countAmount()
            default:
                break
        }
    }
}

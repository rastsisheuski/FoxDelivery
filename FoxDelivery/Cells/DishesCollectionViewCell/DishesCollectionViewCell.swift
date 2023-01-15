//
//  DishesCollectionViewCell.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 14.01.23.
//

import UIKit

class DishesCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: - Public Properties
    
    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.defaultDishImage.image
        return imageView
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let dishNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Киш с курицей и грибами"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "610 гр / 30 см"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "200 ₽."
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let addButton: DishesCellAddButton = {
        let button = DishesCellAddButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutElements()
    }
    
    // MARK: -
    // MARK: - Private Properties
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutElements() {
        layoutDishImageView()
        layoutMainView()
        layoutDishNameLabel()
        layoutDescriptionLabel()
        layoutPriceLabel()
        layoutDishesCellAddButton()
    }
    
    private func layoutDishImageView() {
        contentView.addSubview(dishImageView)
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            dishImageView.widthAnchor.constraint(equalToConstant: 100),
            dishImageView.heightAnchor.constraint(equalToConstant: 100),
            dishImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func layoutMainView() {
        contentView.insertSubview(mainView, belowSubview: dishImageView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: dishImageView.centerYAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.General.defaultSpacing),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutDishNameLabel() {
        mainView.addSubview(dishNameLabel)
        NSLayoutConstraint.activate([
            dishNameLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: Constants.General.defaultSpacing),
            dishNameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.General.defaultSpacing),
            dishNameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutDescriptionLabel() {
        mainView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dishNameLabel.bottomAnchor, constant: Constants.General.defaultSpacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.General.defaultSpacing),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutPriceLabel() {
        mainView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.General.defaultSpacing),
            priceLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: Constants.General.defaultSpacing),
            priceLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutDishesCellAddButton() {
        mainView.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Constants.General.defaultSpacing),
            addButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            addButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
}

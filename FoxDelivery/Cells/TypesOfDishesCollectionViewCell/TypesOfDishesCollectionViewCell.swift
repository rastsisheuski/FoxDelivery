//
//  TypesOfDishesCollectionViewCell.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 14.01.23.
//

import UIKit

class TypesOfDishesCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: - Public Properties
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.General.lightGrayColor
        view.layer.cornerRadius = Constants.TypesOfDishesCollectionViewCell.containerCornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    let dishLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.TypesOfDishesCollectionViewCell.dishLabelFontSize)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var firstAppear = true
    private var typeOfDishes: TypesOfDishesEnum = .kishes
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if firstAppear {
            setupView()
            layoutElements()
            firstAppear = false
        }
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func setupViewWith(typesOfDishes: TypesOfDishesEnum) {
        self.typeOfDishes = typesOfDishes
        containerView.backgroundColor = isSelected ? Colors.TypeOfDish.selectedTypeOfDish : Colors.TypeOfDish.unselectedTypeOfDish
        dishLabel.text = typesOfDishes.russianTranslate
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func layoutElements() {
        layoutContainerView()
        layoutDishLabel()
    }
    
    private func layoutContainerView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.TypesOfDishesCollectionViewCell.containerViewTopConstraint),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.TypesOfDishesCollectionViewCell.containerViewBottomConstraint),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func layoutDishLabel() {
        containerView.addSubview(dishLabel)
        NSLayoutConstraint.activate([
            dishLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dishLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
}

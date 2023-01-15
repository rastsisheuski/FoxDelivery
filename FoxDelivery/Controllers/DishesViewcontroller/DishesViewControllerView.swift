//
//  DishesViewControllerView.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 10.01.23.
//

import UIKit

class DishesViewControllerView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Главная"
        label.font = UIFont.systemFont(ofSize: Constants.DishesViewControllerView.titleLabelFontSize, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .clear
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let typesOfDishesView: TypesOfDishesView = {
        let view = TypesOfDishesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dishesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var firstAppear = true
    
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
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = Colors.DishesViewControllerView.viewBackgroundColor
    }
    
    private func layoutElements() {
        layoutTitleLabel()
        layoutTypesOfDishesView()
        layoutDishesCollectionView()
    }
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.DishesViewControllerView.baseTitleLabelConstraint),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.DishesViewControllerView.baseTitleLabelConstraint),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.DishesViewControllerView.baseTitleLabelConstraint),
        ])
    }
    
    private func layoutTypesOfDishesView() {
        addSubview(typesOfDishesView)
        NSLayoutConstraint.activate([
            typesOfDishesView.heightAnchor.constraint(equalToConstant: Constants.DishesViewControllerView.typesOfDishesViewHeight),
            typesOfDishesView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.DishesViewControllerView.typesOfDishesViewTopConstraint),
            typesOfDishesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            typesOfDishesView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func layoutDishesCollectionView() {
        addSubview(dishesCollectionView)
        NSLayoutConstraint.activate([
            dishesCollectionView.topAnchor.constraint(equalTo: typesOfDishesView.bottomAnchor),
            dishesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dishesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dishesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

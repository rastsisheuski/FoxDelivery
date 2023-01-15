//
//  TypesOfDishesView.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 14.01.23.
//

import UIKit

// MARK: -
// MARK: - Protocols

protocol TypesOfDishesViewDelegate: AnyObject {
    func getSelected(indexPath: IndexPath, typeOfDishes: TypesOfDishesEnum)
}

class TypesOfDishesView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.TypesOfDishesView.separatorViewBackgroundColor
        return view
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var firstAppear = true
    private var dishesTypes = TypesOfDishesEnum.allCases
    private var selectedIndexPath = IndexPath(row: 0, section: 0)
    private var selectedDishesType: TypesOfDishesEnum = .kishes
    
    weak var delegate: TypesOfDishesViewDelegate?
    
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
        registerCell()
        setupCollectionView()
        
        if firstAppear {
            setupView()
            layoutElements()
            firstAppear = false
        }
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func registerCell() {
        collectionView.register(TypesOfDishesCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TypesOfDishesCollectionViewCell.self))
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func layoutElements() {
        layoutCollectionView()
        layoutSeparatorView()
    }
    
    private func layoutCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func layoutSeparatorView() {
        addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.TypesOfDishesView.separatorTrailingConstraint),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.TypesOfDishesView.separatorLeadingConstraint),
            separatorView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.TypesOfDishesView.separatorTopConstraint),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.TypesOfDishesView.separatorHeightConstraint)
        ])
    }
    
    private func calculateTypesOfDishesCollectionViewCellSize() -> CGSize {
        let cellWidth = UIScreen.main.bounds.width / 4
        let cellHeight = cellWidth * 0.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: -
// MARK: - Extensions UICollectionViewDataSource

extension TypesOfDishesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishesTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TypesOfDishesCollectionViewCell.self), for: indexPath)
        guard let typesOfDishesCell = cell as? TypesOfDishesCollectionViewCell else { return cell }
        typesOfDishesCell.isSelected = selectedIndexPath == indexPath
        typesOfDishesCell.setupViewWith(typesOfDishes: dishesTypes[indexPath.row])
        
        return typesOfDishesCell
    }
}

// MARK: -
// MARK: - Extensions UICollectionViewDelegateFlowLayout

extension TypesOfDishesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateTypesOfDishesCollectionViewCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.selectedDishesType = dishesTypes[selectedIndexPath.row]
        delegate?.getSelected(indexPath: selectedIndexPath, typeOfDishes: selectedDishesType)
        collectionView.reloadData()
    }
}

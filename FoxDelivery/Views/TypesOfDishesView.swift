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
    func getSelected(indexPath: IndexPath)
}

class TypesOfDishesView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset.left = Constants.General.defaultSpacing
        collection.contentInset.right = Constants.General.defaultSpacing
        collection.register(TypesOfDishesCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TypesOfDishesCollectionViewCell.self))
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.General.lightGrayColor
        return view
    }()
    
    // MARK: -
    // MARK: - Public Properties
    
    weak var delegate: TypesOfDishesViewDelegate?
    
    // MARK: -
    // MARK: - Private Properties
    
    private var firstAppear = true
    private var dishesTypes = TypesOfDishesEnum.allCases
    private var selectedIndexPath = IndexPath(row: 0, section: 0)
    private var selectedDishesType: TypesOfDishesEnum = .kishes
    
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
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            separatorView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Constants.General.defaultSpacing),
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
        self.selectedDishesType = dishesTypes[indexPath.row]
        delegate?.getSelected(indexPath: indexPath)
        collectionView.reloadData()
    }
}

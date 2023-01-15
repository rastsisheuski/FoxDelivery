//
//  DishesViewController.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 10.01.23.
//

import UIKit

class DishesViewController: NiblessViewController {
    var contentView: DishesViewControllerView {
        view as! DishesViewControllerView
    }
        
    override func loadView() {
        super.loadView()
        
        view = DishesViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
    }
    
    private func setupDelegates() {
        contentView.dishesCollectionView.delegate = self
        contentView.dishesCollectionView.dataSource = self
    }
    
    private func calculateDishCollectionViewCellSize() -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width / 2)
        let cellHeight = cellWidth * 1.75
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension DishesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DishesCollectionViewCell.self), for: indexPath)
        guard let dishesCell = cell as? DishesCollectionViewCell else { return cell }
        return dishesCell
    }
}

extension DishesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateDishCollectionViewCellSize()
    }
}

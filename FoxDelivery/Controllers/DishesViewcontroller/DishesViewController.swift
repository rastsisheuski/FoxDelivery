//
//  DishesViewController.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 10.01.23.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class DishesViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Public Properties
    
    var contentView: DishesViewControllerView {
        view as! DishesViewControllerView
    }

    // MARK: -
    // MARK: - Private Properties

    private let viewModel: DishesViewModel
    private var currentStateOfAddButton: Bool = false
    
    // MARK: -
    // MARK: - LifeCycle
    
    init(viewModel: DishesViewModel) {
        self.viewModel = viewModel
        super.init()
    }
        
    override func loadView() {
        super.loadView()
        
        view = DishesViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        bindViewModel()
        viewModel.getDataFromDataBase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentView.setGradientBackground()
        viewModel.getActualBasketDishesForCurrentUser()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupDelegates() {
        contentView.dishesCollectionView.delegate = self
        contentView.dishesCollectionView.dataSource = self
        
        contentView.typesOfDishesView.delegate = self
    }
    
    private func calculateDishCollectionViewCellSize() -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width / 2)
        let cellHeight = cellWidth * Constants.DishesViewcontroller.collectionViewCellHeightMultiplier
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    private func bindViewModel() {
        viewModel.loading.bind { [weak self] isLoading in
            guard let isLoading else { return }
            self?.configSpinnerState(isLoading)
        }
        
        viewModel.error.bind { [weak self] error in
            guard let error else { return }
            self?.showMessageToUser(title: "Error", msg: error)
        }
        
        viewModel.selectedDishesArray.bind { [weak self] _ in
            self?.contentView.dishesCollectionView.reloadData()
        }
        
        viewModel.currentBasket.bind { [weak self] _ in
            self?.contentView.dishesCollectionView.reloadData()
        }
    }
    
    private func configSpinnerState(_ isLoading: Bool) {
        isLoading ? SpinnerView.shared.createSpiner() : SpinnerView.shared.stopSpiner()
    }
}

// MARK: -
// MARK: - Extension DishesViewController + UICollectionViewDataSource

extension DishesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.selectedDishesArray.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DishesCollectionViewCell.self), for: indexPath)
        guard let dishesCell = cell as? DishesCollectionViewCell else { return cell }
        let currentDish = viewModel.selectedDishesArray.value[indexPath.row]
        let url = URL(string: currentDish.url)
        var isInBasket = false
        
        for basketDish in viewModel.currentBasket.value {
            if basketDish.first?.key == currentDish.id {
                isInBasket = true
            }
        }
        dishesCell.delegate = self
        
        dishesCell.set(for: currentDish, imageURL: url, isInBasket: isInBasket)
        
        return dishesCell
    }
}

// MARK: -
// MARK: - Extension DishesViewController + UICollectionViewDelegateFlowLayout

extension DishesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        calculateDishCollectionViewCellSize()
    }
}

extension DishesViewController: TypesOfDishesViewDelegate {
    func getSelected(indexPath: IndexPath) {
        viewModel.filterArrayOfDishes(by: indexPath.row)
    }
}

extension DishesViewController: DishesCollectionViewCellDelegate {
    func didAddButtonTap(id: String, state: DishesCellAddButtonState) {
        switch state {
        case .active:
            viewModel.apiManager.removeDishFromBasket(id: id) { [weak self] in
                self?.viewModel.getActualBasketDishesForCurrentUser()
            }
        case .disactive:
            viewModel.apiManager.addDishToBasket(id: id) { [weak self] in
                self?.viewModel.getActualBasketDishesForCurrentUser()
            }
        }
    }
}

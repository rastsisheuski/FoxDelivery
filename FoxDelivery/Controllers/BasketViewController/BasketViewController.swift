//
//  BasketViewController.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 30.01.23.
//

import UIKit

class BasketViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Public Properties 
    
    var contentView: BasketViewControllerView {
        view as! BasketViewControllerView
    }
    
    // MARK: -
    // MARK: - Private Properties
    
    private let viewModel: BasketViewModel
    private var currentBasketDishModels: [DishModel] = []
    private var currentBasketDishes: [[String : Int]] = [[:]]
    
    // MARK: -
    // MARK: - LifeCycle
    
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        view = BasketViewControllerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegates()
        bindViewModel()
        setupOrderButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentView.setGradientBackground()
        currentBasketDishes.removeAll()
        currentBasketDishModels.removeAll()
        viewModel.getActualBasketDishesForCurrentUser()
    }
    
    private func setupDelegates() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.movingView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.currentBasketDishModels.bind { [weak self] dishModels in
            self?.currentBasketDishModels = dishModels
            self?.contentView.tableView.reloadData()
        }
        
        viewModel.currentBasketDishes.bind { [weak self] dishes in
            self?.currentBasketDishes = dishes
            self?.viewModel.getDishModelsFromBasketDishes(currentBasketDishes: dishes)
        }
    }
    
    private func findDishIndex(dishToDelete: DishModel) -> Int {
        for (index, dish) in currentBasketDishModels.enumerated() {
            if dish.id == dishToDelete.id {
                return index
            }
        }
        return 0
    }
    
    private func setupOrderButton() {
        let order = "Заказать"
        let amount = "getTotalAmount()"
        let time = "45 - 50 мин"
        let model = OrderButtonModel(order: order, time: time, amount: amount)
        contentView.movingView.orderButton.setupButtonLabels(model: model)
    }

}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentBasketDishModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.id, for: indexPath)
        
        guard let basketCell = cell as? BasketTableViewCell else { return cell }
        
        basketCell.set(selectedModel: currentBasketDishModels[indexPath.row])
        basketCell.delegate = self
        basketCell.swipeGesture?.delegate = self
        basketCell.selectionStyle = .none
        return basketCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension BasketViewController: BasketTableViewCellDelegate {
    func deleteCellFromTableView(dishToDelete: DishModel) {
        let indexToDelete = findDishIndex(dishToDelete: dishToDelete)
        let indexPathToDelete = IndexPath(item: indexToDelete, section: 0)
        viewModel.getActualBasketDishesForCurrentUser()
        
        guard let currentDishInfo = currentBasketDishes.filter({ $0.keys.first == dishToDelete.id}).first else { return }
        
        viewModel.deleteFromBasket(dishInfo: currentDishInfo)
        currentBasketDishModels.remove(at: indexToDelete)
        contentView.tableView.deleteRows(at: [indexPathToDelete], with: .left)
        
        viewModel.getActualBasketDishesForCurrentUser()
    }
}

extension BasketViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        let velocity = gestureRecognizer.velocity(in: contentView.tableView)
        return abs(velocity.x) > abs(velocity.y)
    }
}

extension BasketViewController: MovingBasketViewDelegate {
    func getContentInsetValue(_ inset: CGFloat) {
        contentView.tableView.contentInset.bottom = inset
    }
}

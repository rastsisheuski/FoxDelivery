//
//  MovingBasketView.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 30.01.23.
//

protocol MovingBasketViewDelegate: AnyObject {
    func getContentInsetValue(_ inset: CGFloat)
}

import UIKit

class TestView: UIView {
    weak var delegate: MovingBasketViewDelegate?
    
    override var bounds: CGRect {
        didSet {
            delegate?.getContentInsetValue(bounds.height - Constants.TabBar.tabBarHeight)
        }
    }
}

final class MovingBasketView: TestView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let hookView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.General.lightGrayColor
        return view
    }()
    
    let tableView: SelfSizingTableView = {
        let tableView = SelfSizingTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = false
        tableView.separatorStyle = .none
        tableView.register(MovingBasketViewCell.self, forCellReuseIdentifier: MovingBasketViewCell.id)
        return tableView
    }()
    
    let orderButton: OrderButton = {
        let button = OrderButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var firstAppear = true
    private let defaultDeliveryCount = 300
    private var leadingBeginGestureConstant: CGFloat = 0
    private var trailingBeginGestureConstant: CGFloat = 0
    private var defaultDeliveryInfo: MovingBasketViewCellModel?
    private var defaultTotalInfo: MovingBasketViewCellModel?
    private var tableViewData: [MovingBasketViewCellModel] = []
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupDelegates()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if firstAppear {
            layoutElements()
            delegate?.getContentInsetValue(self.bounds.height)
            firstAppear = false
        }
    }
    
    // MARK: -
    // MARK: - Private Properties
    
    private func setupDelegates() {
        tableView.dataSource = self
    }
    
    private func setupUI() {
        layer.cornerRadius = 40
        clipsToBounds = true
        layer.maskedCorners = [.layerMaxXMinYCorner,  .layerMinXMinYCorner]
        setupDefaultInfoForCells(with: defaultDeliveryCount)
        self.setGradientBackground()
    }
    
    private func setupGesture() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.up, .down]
        for direction in directions {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToPanGesture(sender:)))
            swipe.direction = direction
            self.addGestureRecognizer(swipe)
        }
    }
    
    private func animateTableView() {
        delegate?.getContentInsetValue(self.bounds.height)
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.tableView.layoutIfNeeded()
        }
    }
    
    private func showTotalPrice() {
        guard let defaultTotalInfo else { return }
        
        if tableViewData.contains(defaultTotalInfo) {
            return
        }
        tableViewData.append(defaultTotalInfo)
        tableView.reloadData()
        animateTableView()
    }
    
    private func hideTotalPrice() {
        guard let defaultTotalInfo else { return }
        
        if !tableViewData.contains(defaultTotalInfo) {
            return
        }
        
        for (index,item) in tableViewData.enumerated() {
            if item == defaultTotalInfo {
                tableViewData.remove(at: index)
            }
        }
        
        tableView.reloadData()
        animateTableView()
    }
    
    private func setupDefaultInfoForCells(with deliveryPrice: Int) {
        defaultDeliveryInfo = MovingBasketViewCellModel(
            image: Icons.deliveryBasketIcon.image,
            title: "Доставка",
            amount: deliveryPrice
        )
        
        defaultTotalInfo = MovingBasketViewCellModel(
            image: Icons.totalBasketIcon.image,
            title: "Итого:",
            amount: deliveryPrice
        )
        
        guard let defaultDeliveryInfo else { return }
        guard let defaultTotalInfo else { return }
        
        tableViewData.append(defaultDeliveryInfo)
        tableViewData.append(defaultTotalInfo)
    }
    
    private func layoutElements() {
        layoutHookView()
        layoutTableView()
        layoutOrderButton()
    }
    
    private func layoutHookView() {
        addSubview(hookView)
        
        NSLayoutConstraint.activate([
            hookView.widthAnchor.constraint(equalToConstant: Constants.MovingBasketView.hookViewWidth),
            hookView.heightAnchor.constraint(equalToConstant: Constants.MovingBasketView.hookViewHeight),
            hookView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.MovingBasketView.hookViewTopConstraint),
            hookView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutTableView() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: hookView.bottomAnchor, constant: Constants.MovingBasketView.tableViewTopConstraint),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
        ])
    }
    
    private func layoutOrderButton() {
        addSubview(orderButton)
        
        NSLayoutConstraint.activate([
            orderButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Constants.General.defaultSpacing),
            orderButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            orderButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.MovingBasketView.orderButtonBottomConstraint)
        ])
    }
}

// MARK: -
// MARK: - Extension MovingBasketView + UITableViewDataSource

extension MovingBasketView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovingBasketViewCell.id, for: indexPath)
        (cell as? MovingBasketViewCell)?.set(model: tableViewData[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: -
// MARK: - Extension MovingBasketView + UIPanGestureRecognizer Action

extension MovingBasketView {
    @objc private func respondToPanGesture(sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
            case .up:
                showTotalPrice()
            case .down:
                hideTotalPrice()
            default: return
        }
    }
}

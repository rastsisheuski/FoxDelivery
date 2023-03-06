//
//  BasketViewControllerView.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 30.01.23.
//

import UIKit

final class BasketViewControllerView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.id)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    let movingView: MovingBasketView  = {
        let view = MovingBasketView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = Colors.BasketViewControllerView.viewBackgroundColor
    }
    
    private func layoutElements() {
        layoutTableView()
        layoutMovingView()
    }
    
    private func layoutTableView() {
        addSubview(tableView)
        
        tableView.fillSuperview()
    }
    
    private func layoutMovingView() {
        addSubview(movingView)
        
        NSLayoutConstraint.activate([
            movingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

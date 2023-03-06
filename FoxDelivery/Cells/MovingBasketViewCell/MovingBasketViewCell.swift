//
//  MovingBasketViewCell.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 5.03.23.
//

struct MovingBasketViewCellModel: Equatable {
    var image: UIImage
    var title: String
    var amount: Int
}

import UIKit

class MovingBasketViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: - Public Properties
    
    static let id = String(describing: MovingBasketViewCell.self)
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Colors.General.selectedButton
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var firstAppear = true
    
    // MARK: -
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if firstAppear {
            layoutElements()
            setupUI()
            firstAppear = false
        }
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func set(model: MovingBasketViewCellModel) {
        iconImageView.image = model.image.withRenderingMode(.alwaysTemplate)
        titleLabel.text = model.title
        amountLabel.text = "\(model.amount)  ₽."
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func layoutElements() {
        layoutIconImageView()
        layoutTitleLabel()
        layoutAmountLabel()
    }
    
    private func setupUI() {
        backgroundColor = .clear
    }
    
    private func layoutIconImageView() {
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func layoutTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.General.defaultSpacing),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func layoutAmountLabel() {
        addSubview(amountLabel)
        
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}



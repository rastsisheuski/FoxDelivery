//
//  BasketTableViewCell.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 4.03.23.
//

protocol BasketTableViewCellDelegate: AnyObject {
    func deleteCellFromTableView(dishToDelete: DishModel)
}

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: - Public Properties
    
    static let id = String(describing: BasketTableViewCell.self)
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.General.selectedButton
        return view
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "basket"), for: .normal)
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    let customBasketItemView: CustomBasketItemView = {
        let view = CustomBasketItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var swipeGesture: UIPanGestureRecognizer?
    weak var delegate: BasketTableViewCellDelegate?
    
    // MARK: -
    // MARK: - Private Properties
    
    private var dishModelToDelete: DishModel?
    private var customBasketItemLeadingConstraint: NSLayoutConstraint!
    private var customBasketItemTrailingConstraint: NSLayoutConstraint!
    private let customBasketItemBaseLeadingConstant: CGFloat = 0
    private let customBasketItemBaseTrailingConstant: CGFloat = 0
    private var leadingBeginGestureConstant: CGFloat = 0
    private var trailingBeginGestureConstant: CGFloat = 0
    private let separationConstraint: CGFloat = 16
    
    private var firstAppear = true
    
    // MARK: -
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        layoutElements()
        setupGesture()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func set(selectedModel: DishModel) {
        self.dishModelToDelete = selectedModel
        customBasketItemView.set(selectedModel: selectedModel)
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupUI() {
        mainView.layer.cornerRadius = 30
        mainView.clipsToBounds = true
        backgroundColor = .clear
    }
    
    private func setupGesture() {
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(respondToPanGesture(sender: )))
        swipeGesture = swipe
        self.customBasketItemView.addGestureRecognizer(swipe)
    }
    
    private func moveToStartPosition() {
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            guard let self else { return }
            self.customBasketItemLeadingConstraint.constant = self.customBasketItemBaseLeadingConstant
            self.customBasketItemTrailingConstraint.constant = self.customBasketItemBaseTrailingConstant
            self.layoutIfNeeded()
        }
    }
    
    private func moveToDeleteButtonPosition() {
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            guard let self else { return }
            self.customBasketItemTrailingConstraint.constant = self.customBasketItemBaseTrailingConstant - self.deleteButton.frame.width - self.separationConstraint
            self.customBasketItemLeadingConstraint.constant = self.customBasketItemBaseLeadingConstant - self.deleteButton.frame.width - self.separationConstraint
            self.customBasketItemTrailingConstraint.isActive = true
            self.layoutIfNeeded()
        }
    }
    
    private func moveToEndPosition(completion: @escaping (() -> ()?)) {
        UIView.animate(withDuration: 0.3, delay: 0) { [weak self] in
            guard let self else { return }
            self.customBasketItemTrailingConstraint.constant = self.customBasketItemBaseTrailingConstant - UIScreen.main.bounds.width
            self.customBasketItemLeadingConstraint.constant = self.customBasketItemBaseLeadingConstant - self.deleteButton.frame.width - UIScreen.main.bounds.width
            self.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
    
    private func layoutElements() {
        layoutMainView()
        layoutDeleteButton()
        layoutCustomBasketItemView()
    }
    
    private func layoutMainView() {
        contentView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.BasketTableViewCell.mainViewLeadingAndTrailingPConstraints),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.BasketTableViewCell.mainViewLeadingAndTrailingPConstraints),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.BasketTableViewCell.mainViewTopAndBottomConstraints),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.BasketTableViewCell.mainViewTopAndBottomConstraints)
        ])
    }
    
    private func layoutDeleteButton() {
        mainView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -Constants.General.defaultSpacing),
        ])
    }
    
    private func layoutCustomBasketItemView() {
        mainView.addSubview(customBasketItemView)
        
        NSLayoutConstraint.activate([
            customBasketItemView.topAnchor.constraint(equalTo: mainView.topAnchor),
            customBasketItemView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
        customBasketItemLeadingConstraint = customBasketItemView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor)
        customBasketItemTrailingConstraint = customBasketItemView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        
        customBasketItemLeadingConstraint.isActive = true
        customBasketItemTrailingConstraint.isActive = true
    }
}

extension BasketTableViewCell {
    @objc private func respondToPanGesture(sender: UIPanGestureRecognizer) {
        // даёт понятие в какую сторону у нас свайп (+ -- вправо, - -- влево)
        let xVelocity = sender.velocity(in: customBasketItemView).x
        switch sender.state {
            case .began:
                print("начало движения")
                leadingBeginGestureConstant = customBasketItemLeadingConstraint.constant
                trailingBeginGestureConstant = customBasketItemTrailingConstraint.constant
            case .changed:
                let newLeadingConstant = leadingBeginGestureConstant + sender.translation(in: mainView).x
                let newTrailingConstant = trailingBeginGestureConstant + sender.translation(in: mainView).x
                
                guard newLeadingConstant <= customBasketItemBaseLeadingConstant else {
                    customBasketItemLeadingConstraint.constant = customBasketItemBaseLeadingConstant
                    customBasketItemTrailingConstraint.constant = customBasketItemBaseTrailingConstant
                    return
                }
                
                customBasketItemLeadingConstraint.constant = newLeadingConstant
                customBasketItemTrailingConstraint.constant = newTrailingConstant
                
                print(xVelocity)
            case .ended:
                if customBasketItemView.frame.maxX > mainView.frame.maxX / 1.3 {
                    print("Вернуть в исходное положение")
                    moveToStartPosition()
                } else if customBasketItemView.frame.maxX > mainView.frame.maxX / 2 {
                    print("Вернуться в положение кнопки")
                    moveToDeleteButtonPosition()
                } else {
                    print("Перейти в положение удалить")
                    moveToEndPosition { [weak self] in
                        guard let self else { return }
                        guard let dishModelToDelete = self.dishModelToDelete else { return }
                        self.delegate?.deleteCellFromTableView(dishToDelete: dishModelToDelete)
                    }
                }
            default:
                print("Failed")
        }
    }
}


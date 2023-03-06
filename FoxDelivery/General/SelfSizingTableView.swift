//
//  SelfSizingTableView.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 30.01.23.
//

import UIKit

final class SelfSizingTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var contentSize: CGSize {
        didSet {
            layoutIfNeeded()
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}

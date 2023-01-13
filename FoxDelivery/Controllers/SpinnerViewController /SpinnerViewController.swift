//
//  SpinnerViewController.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 9.01.23.
//

import Foundation

class SpinnerViewController: NiblessViewController {
    var contentView: SpinnerViewControllerView {
        view as! SpinnerViewControllerView
    }
    
    override func loadView() {
        super.loadView()
        
        view = SpinnerViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.activityIndicator.startAnimating()
    }
}

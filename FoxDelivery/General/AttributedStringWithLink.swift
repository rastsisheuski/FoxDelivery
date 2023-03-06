//
//  AttributedStringWithLink.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 2.01.23.
//

import UIKit

class AttributedStringWithLink: UILabel {
    
    // MARK: -
    // MARK: - Public Properties
    
    var contentText: String = ""
    var linkWord: String = ""
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(contentText: String, linkWord: String) {
        super.init(frame: .zero)
        
        self.contentText = contentText
        self.linkWord = linkWord
        
        configureSubViews(contentText: contentText, linkWord: linkWord)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func configureSubViews(contentText: String, linkWord: String) {
        let attributeMutableStringLink = NSMutableAttributedString(string: contentText)
        attributeMutableStringLink.addAttribute(.link, value: "https://www.pornhub.com", range: contentText.createRangeInLink(of: linkWord))
//        attributeMutableStringLink.addAttributes([.link : "https://www.pornhub.com",
//                                                  NSAttributedString.Key.foregroundColor : UIColor.red,
//                                                  NSAttributedString.Key.underlineStyle : NSUnderlineStyle.
//                                                 ], range: contentText.createRangeInLink(of: linkWord))
        
        self.attributedText = attributeMutableStringLink
    }
}




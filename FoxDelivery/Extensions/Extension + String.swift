//
//  Extension + String.swift
//  FoxDelivery
//
//  Created by Hleb Rastsisheuski on 4.03.23.
//

import Foundation

extension String {
    func createRangeInLink(of findWord: String) -> NSRange {
        let range = (self as NSString).range(of: findWord, options: .caseInsensitive)
        return range
    }
}

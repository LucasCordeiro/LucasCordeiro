//
//  ExtensionCenter.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 16/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit

extension UIView {

    /// Get UIView's class name
    ///
    /// - Returns: UIView's class name
    static func viewDescription() -> String {
        return String(describing: self)
    }
}

extension UIViewController {

    /// Get ViewController's class name
    ///
    /// - Returns: ViewController's class name
    static func viewControllerDescription() -> String {
        return String(describing: self)
    }
}

extension String {

    /// Convert a date string from a format to other.
    ///
    /// - Parameters:
    ///   - fromFormat: origin format of string
    ///   - toFormat: format to be converted
    /// - Returns: date string converted
    /// or if string does not match date, nil
    func convertDate(fromFormat: String, toFormat: String) -> String? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat

        guard let showDate = dateFormatter.date(from: self) else {
                return nil
        }

        dateFormatter.dateFormat = toFormat

        return dateFormatter.string(from: showDate)
    }
}

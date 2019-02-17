//
//  ExtensionCenter.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 16/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit
import Lottie

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

extension LOTAnimationView {
    func showAndPlay(loopAnimation: Bool) {

        self.loopAnimation = loopAnimation
        self.play()

        self.isHidden = false
        self.superview?.isHidden = false
        self.alpha = 0.0
        self.superview?.alpha = 0.0

        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
            self.superview?.alpha = 0.35
        }
    }

    func hideAndStop() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
            self.superview?.alpha = 0.0
        }) { (_) in
            self.stop()
            self.superview?.isHidden = true
            self.isHidden = true
        }
    }
}

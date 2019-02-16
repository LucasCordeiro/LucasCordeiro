//
//  ExtensionCenter.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 16/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import UIKit

extension UIView {
    
    static func viewDescription() -> String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    static func viewControllerDescription -> String {
        return String(describing: self)
    }
}

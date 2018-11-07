//
//  UIStoryboard.swift
//  MASCore iOS
//
//  Created by Gregory Higley on 9/24/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    convenience init(name: UIStoryboard.Name, bundle: Bundle? = nil) {
        self.init(name: String(describing: name), bundle: bundle)
    }
    
    func instantiateViewController(withIdentifier identifier: UIStoryboard.Identifier) -> UIViewController {
        return instantiateViewController(withIdentifier: String(describing: identifier))
    }
}

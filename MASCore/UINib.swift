//
//  UINib.swift
//  MASCore iOS
//
//  Created by Gregory Higley on 10/10/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import UIKit

public extension UINib {
    convenience init(nibName name: UINib.Name, bundle: Bundle? = nil) {
        self.init(nibName: String(describing: name), bundle: bundle)
    }
}

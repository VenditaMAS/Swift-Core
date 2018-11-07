//
//  UITableView.swift
//  MASCore iOS
//
//  Created by Gregory Higley on 10/10/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func dequeueReusableCell(withIdentifier identifier: UITableViewCell.ReuseIdentifier, for indexPath: IndexPath? = nil) -> UITableViewCell? {
        let identifier = String(describing: identifier)
        if let indexPath = indexPath {
            return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        } else {
            return dequeueReusableCell(withIdentifier: identifier)
        }
    }
    
    func register(nib: UINib, forCellReuseIdentifier identifier: UITableViewCell.ReuseIdentifier) {
        register(nib, forCellReuseIdentifier: String(describing: identifier))
    }
    
    func register(cellReuseIdentifier reuseIdentifier: UITableViewCell.ReuseIdentifier, bundle: Bundle? = nil) {
        let nib = UINib(nibName: "\(reuseIdentifier)TableViewCell", bundle: bundle)
        register(nib: nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
}

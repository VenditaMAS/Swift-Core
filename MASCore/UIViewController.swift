//
//  UIViewController.swift
//  MASCore iOS
//
//  Created by Gregory Higley on 9/24/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import UIKit

public extension UIViewController {
    var splitViewController: UISplitViewController? {
        return ancestor()
    }
    
    func ancestor<ViewController: UIViewController>(ofType type: ViewController.Type = ViewController.self) -> ViewController? {
        return MASCore.ancestor(of: self, in: \.parent)
    }
    
    func descendants<ViewController: UIViewController>(ofType type: ViewController.Type = ViewController.self) -> [ViewController] {
        loadViewIfNeeded()
        return MASCore.descendants(of: self, in: \.children)
    }
    
    func firstDescendant<ViewController: UIViewController>(ofType type: ViewController.Type = ViewController.self) -> ViewController? {
        loadViewIfNeeded()
        return MASCore.firstDescendant(of: self, in: \.children)
    }
    
    func performSegue(withIdentifier identifier: UIStoryboardSegue.Identifier, sender: Any?) {
        performSegue(withIdentifier: String(describing: identifier), sender: sender)
    }
    
    func shouldPerformSegue(withIdentifier identifier: UIStoryboardSegue.Identifier, sender: Any?) -> Bool {
        return shouldPerformSegue(withIdentifier: String(describing: identifier), sender: sender)
    }
}

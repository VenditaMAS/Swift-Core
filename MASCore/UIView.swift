//
//  UIView.swift
//  MASCore iOS
//
//  Created by Gregory Higley on 10/7/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import UIKit

public extension UIView {
    
    var firstResponder: UIView? {
        return MASCore.firstDescendant(of: self, in: \.subviews, where: \.isFirstResponder)
    }
    
    func ancestor<Ancestor: UIView>(ofType type: Ancestor.Type = Ancestor.self) -> Ancestor? {
        return MASCore.ancestor(of: self, in: \.superview)
    }
    
    func firstDescendant<Descendant: UIView>(ofType type: Descendant.Type = Descendant.self) -> Descendant? {
        return MASCore.firstDescendant(of: self, in: \.subviews)
    }
    
    func descendants<Descendant: UIView>(ofType type: Descendant.Type = Descendant.self) -> [Descendant] {
        return MASCore.descendants(of: self, in: \.subviews)
    }
    
}

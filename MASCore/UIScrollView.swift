//
//  UIScrollView.swift
//  MASCore iOS
//
//  Created by Gregory Higley on 10/7/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import UIKit

public extension UIScrollView {
    var visibleRect: CGRect {
        return CGRect(origin: contentOffset, size: bounds.size)
    }
}

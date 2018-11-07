//
//  CGImage.swift
//  MASCore
//
//  Created by Gregory Higley on 10/9/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

public extension CGImage {
    
    // https://stackoverflow.com/a/48281568/27779
    func colors(at: [CGPoint]) -> [UIColor] {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo),
            let ptr = context.data?.assumingMemoryBound(to: UInt8.self) else {
                return []
        }
        
        context.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        return at.map { p in
            let i = bytesPerRow * Int(p.y) + bytesPerPixel * Int(p.x)
            
            let a = CGFloat(ptr[i + 3]) / 255.0
            let r = (CGFloat(ptr[i]) / a) / 255.0
            let g = (CGFloat(ptr[i + 1]) / a) / 255.0
            let b = (CGFloat(ptr[i + 2]) / a) / 255.0
            
            return UIColor(red: r, green: g, blue: b, alpha: a)
        }
    }
}

//
//  Array.swift
//
//  Created by Gregory Higley on 4/1/17.
//  Copyright (c) 2017, 2018 Revolucent LLC & Gregory Higley. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

public extension Array {
    
    // Modified a bit from https://stackoverflow.com/a/43107628/27779
    func dictionary<Key, Value>(_ isIncluded: Predicate<Dictionary<Key, Value>.Element> = { _ in true }) -> [Key: Value] where Element == Dictionary<Key, Value>.Element {
        var dictionary: [Key: Value] = [:]
        for element in self {
            if !isIncluded(element) { continue }
            dictionary[element.key] = element.value
        }
        return dictionary
    }
    
    // Inspired by https://stackoverflow.com/a/43107628/27779
    func dictionary<Key, Value, Transformed>(_ transform: Transform<Value, Transformed>) rethrows -> [Key: Transformed] where Element == Dictionary<Key, Value>.Element {
        var dictionary: [Key: Transformed] = [:]
        for element in self {
            dictionary[element.key] = try transform(element.value)
        }
        return dictionary
    }
    
    subscript(safe index: Int) -> Element? {
        if !indices.contains(index) { return nil }
        return self[index]
    }
    
    func appending(_ newElement: Element) -> [Element] {
        var array = self
        array.append(newElement)
        return array
    }
    
    func appending<S: Sequence>(contentsOf sequence: S) -> [Element] where S.Element == Element {
        var array = self
        array.append(contentsOf: sequence)
        return array
    }
}

//
//  CallbackCaller.swift
//
//  Created by Gregory Higley on 3/22/16.
//  Copyright © 2017, 2018 Revolucent LLC & Gregory Higley. All rights reserved.
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

/// Contains helper methods for calling a callback on a particular queue.
public struct CallbackCaller {
    
    private init() {}
    
    public static func call<Param>(_ callback: Callback<Param>?, with param: Param, on queue: DispatchQueue?) {
        guard let callback = callback else { return }
        if let queue = queue {
            queue.async {
                callback(param)
            }
        } else {
            callback(param)
        }
    }
    
    public static func call(_ callback: Callback<Void>?, on queue: DispatchQueue?) {
        call(callback, with: (), on: queue)
    }

    public static func calling<Param>(_ callback: Callback<Param>?, on queue: DispatchQueue?) -> Callback<Param>? {
        guard let callback = callback else { return nil }
        return { call(callback, with: $0, on: queue) }
    }
    
    public static func calling<Param>(_ callback: Callback<Param>?, on queue: DispatchQueue?) -> Callback<Param> {
        return { call(callback, with: $0, on: queue) }
    }

}

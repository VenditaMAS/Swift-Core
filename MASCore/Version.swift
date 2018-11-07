//
//  Version.swift
//
//  Created by Gregory Higley on 9/4/15.
//  Copyright © 2015, 2016, 2017, 2018 Revolucent LLC & Gregory Higley. All rights reserved.
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

public struct Version: CustomStringConvertible, Hashable, Comparable, Codable {
    
    public private(set) var major: Int
    public private(set) var minor: Int
    public private(set) var build: Int
    
    public var description: String {
        return "\(major).\(minor).\(build)"
    }
    
    public init(major: Int, minor: Int, build: Int) {
        self.major = major
        self.minor = minor
        self.build = build
    }
    
    public init?(_ version: String) {
        let pattern = "\\d+"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(version.startIndex..<version.endIndex, in: version)
        let matches = regex.matches(in: version, options: [], range: range)
        if ![2, 3].contains(matches.count) { return nil }
        var major: Int?
        var minor: Int?
        var build: Int?
        for match in matches {
            let number = Int(version[Range(match.range, in: version)!])!
            if major == nil {
                major = number
            } else if minor == nil {
                minor = number
            } else if build == nil {
                build = number
            }
        }
        self.init(major: major ?? 0, minor: minor ?? 0, build: build ?? 0)
    }
    
    public init?(dictionary: [String: Any]) {
        guard let short = dictionary["CFBundleShortVersionString"] as? String else {
            return nil
        }
        guard let buildString = dictionary["CFBundleVersion"] as? String, let build = Int(buildString) else {
            return nil
        }
        let versionInfo = short.split() { $0 == "." }
        guard let major = Int(String(versionInfo[0])) else {
            return nil
        }
        guard let minor = Int(String(versionInfo[1])) else {
            return nil
        }
        self.init(major: major, minor: minor, build: build)
    }
    
    public init?(bundle: Bundle) {
        guard let dictionary = bundle.infoDictionary else { return nil }
        self.init(dictionary: dictionary)
    }
    
    public init?() {
        self.init(bundle: .main)
    }
    
    public static func ==(lhs: Version, rhs: Version) -> Bool {
        return (lhs.major, lhs.minor, lhs.build) == (rhs.major, rhs.minor, rhs.build)
    }
    
    public static func <(lhs: Version, rhs: Version) -> Bool {
        return (lhs.major, lhs.minor, lhs.build) < (rhs.major, rhs.minor, rhs.build)
    }
    
}


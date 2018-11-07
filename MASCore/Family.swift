//
//  Family.swift
//  MASCore
//
//  Created by Gregory Higley on 10/28/18.
//  Copyright © 2018 Gregory Higley. All rights reserved.
//
// The code in this file is released under the MIT license and
// can be found at https://gist.github.com/Revolucent/57243a43993a5ff5d5ee755542c14538
//

import Foundation

public func descendants<Descendant>(of parent: Descendant, in attribute: KeyPath<Descendant, [Descendant]>, where: (Descendant) throws -> Bool) rethrows -> [Descendant] {
    var descendants: [Descendant] = []
    for child in parent[keyPath: attribute] {
        if try `where`(child) {
            descendants.append(child)
        }
        try descendants.append(contentsOf: MASCore.descendants(of: child, in: attribute, where: `where`))
    }
    return descendants
}

public func descendants<Descendant>(of parent: Descendant, in attribute: KeyPath<Descendant, [Descendant]>, where: KeyPath<Descendant, Bool>) -> [Descendant] {
    return descendants(of: parent, in: attribute, where: { $0[keyPath: `where`] })
}

public func descendants<Parent, Descendant>(of parent: Parent, in attribute: KeyPath<Parent, [Parent]>, ofType type: Descendant.Type = Descendant.self) -> [Descendant] {
    var descendants: [Descendant] = []
    for child in parent[keyPath: attribute] {
        if let descendant = child as? Descendant {
            descendants.append(descendant)
        }
        descendants.append(contentsOf: MASCore.descendants(of: child, in: attribute, ofType: type))
    }
    return descendants
}

public func firstDescendant<Descendant>(of parent: Descendant, in attribute: KeyPath<Descendant, [Descendant]>, where: (Descendant) throws -> Bool) rethrows -> Descendant? {
    for child in parent[keyPath: attribute] {
        if try `where`(child) { return child }
        if let descendant = try firstDescendant(of: child, in: attribute, where: `where`) {
            return descendant
        }
    }
    return nil
}

public func firstDescendant<Descendant>(of parent: Descendant, in attribute: KeyPath<Descendant, [Descendant]>, where: KeyPath<Descendant, Bool>) -> Descendant? {
    return firstDescendant(of: parent, in: attribute, where: { $0[keyPath: `where`] })
}

public func firstDescendant<Parent, Descendant>(of parent: Parent, in attribute: KeyPath<Parent, [Parent]>, ofType type: Descendant.Type = Descendant.self) -> Descendant? {
    for child in parent[keyPath: attribute] {
        if let descendant = child as? Descendant {
            return descendant
        }
        if let descendant = firstDescendant(of: child, in: attribute, ofType: type) {
            return descendant
        }
    }
    return nil
}

public func ancestor<Ancestor>(of child: Ancestor, in attribute: KeyPath<Ancestor, Ancestor?>, where: (Ancestor) throws -> Bool) rethrows -> Ancestor? {
    if let parent = child[keyPath: attribute] {
        if try `where`(parent) { return parent }
        return try ancestor(of: parent, in: attribute, where: `where`)
    }
    return nil
}

public func ancestor<Ancestor>(of child: Ancestor, in attribute: KeyPath<Ancestor, Ancestor?>, where: KeyPath<Ancestor, Bool>) -> Ancestor? {
    return ancestor(of: child, in: attribute, where: { $0[keyPath: `where`] })
}

public func ancestor<Parent, Ancestor>(of child: Parent, in attribute: KeyPath<Parent, Parent?>, ofType type: Ancestor.Type = Ancestor.self) -> Ancestor? {
    if let parent = child[keyPath: attribute] {
        if let ancestor = parent as? Ancestor {
            return ancestor
        }
        return ancestor(of: parent, in: attribute, ofType: type)
    }
    return nil
}


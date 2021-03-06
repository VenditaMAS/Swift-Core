//
//  Transform.swift
//  MAS
//
//  Created by Gregory Higley on 7/17/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

public typealias Transform<Input, Output> = (Input) throws -> Output

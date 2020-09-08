//
//  DatabaseEntryPrimaryKey.swift
//  
//
//  Created by Gray Campbell on 9/8/20.
//

import Foundation

public protocol DatabaseEntryPrimaryKey: DatabaseEntryProperty {}

extension String: DatabaseEntryPrimaryKey {}
extension Int: DatabaseEntryPrimaryKey {}

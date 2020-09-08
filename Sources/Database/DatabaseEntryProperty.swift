//
//  DatabaseEntryProperty.swift
//  
//
//  Created by Gray Campbell on 9/8/20.
//

import Foundation
import RealmSwift

public protocol DatabaseEntryProperty {}

extension Bool: DatabaseEntryProperty {}
extension Int: DatabaseEntryProperty {}
extension Int8: DatabaseEntryProperty {}
extension Int16: DatabaseEntryProperty {}
extension Int32: DatabaseEntryProperty {}
extension Int64: DatabaseEntryProperty {}
extension Double: DatabaseEntryProperty {}
extension Float: DatabaseEntryProperty {}
extension String: DatabaseEntryProperty {}
extension Date: DatabaseEntryProperty {}
extension Data: DatabaseEntryProperty {}
extension RealmOptional: DatabaseEntryProperty {}

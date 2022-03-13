//
//  Country.swift
//  RealmDemo
//
//  Created by Alper Kayabasi on 30.01.2022.
//

import Foundation
import RealmSwift

class Country: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var flag: String
}

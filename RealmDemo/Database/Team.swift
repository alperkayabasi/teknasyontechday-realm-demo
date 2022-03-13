//
//  Team.swift
//  RealmDemo
//
//  Created by Alper Kayabasi on 30.01.2022.
//

import Foundation
import RealmSwift

class Team: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var drivers: List<Driver> // one-to-many relationship
}

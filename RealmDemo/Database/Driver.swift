//
//  Driver.swift
//  RealmDemo
//
//  Created by Alper Kayabasi on 30.01.2022.
//

import Foundation
import RealmSwift

class Driver: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var country: Country
    @Persisted var number: Int?
    @Persisted var status: DriverStatusEnum
        
    @Persisted(originProperty: "drivers") var team: LinkingObjects<Team>
}

enum DriverStatusEnum: String, PersistableEnum {
    case active
    case passive
    case retired
}

//
//  Track.swift
//  RealmDemo
//
//  Created by Alper Kayabasi on 30.01.2022.
//

import Foundation
import RealmSwift

class Track: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var trackCountry: Country // one-to-one relationship
    @Persisted var fastestLapDriver: Driver? // optional field
}

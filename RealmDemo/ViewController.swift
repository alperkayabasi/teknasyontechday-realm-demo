//
//  ViewController.swift
//  RealmDemo
//
//  Created by Alper Kayabasi on 30.01.2022.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    private let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

// MARK: - Write & Read

extension ViewController {
    
    private func getDriver() {
        let driver = realm.object(ofType: Driver.self, forPrimaryKey: "1")
    }
    
    private func getAllTeams() {
        let teams = realm.objects(Team.self)
    }
    
    private func getSpanishDrivers() {
        let spanishDrivers = realm.objects(Driver.self).where {
            $0.country.name == "Spain"
        }
    }
    
    private func getSortedDriversByNumber() {
        let sortedDrivers = realm.objects(Driver.self).sorted(byKeyPath: "number", ascending: false)
    }
    
    private func getAndModifyDriver() {
        let hamilton = realm.objects(Driver.self).where {
            $0.number == 44
        }.first!
        
        try! realm.write {
            hamilton.status = .retired
        }
    }
    
    private func deleteMazepin() {
        let mazepin = realm.object(ofType: Driver.self, forPrimaryKey: "202209")
        
        try! realm.write {
            realm.delete(mazepin!)
        }
    }
    
    private func deleteAllTracks() {
        let tracks = realm.objects(Track.self)
        
        try! realm.write {
            realm.delete(tracks)
        }
    }
    
    private func getFilteredTracks() {
        let newTracks = realm.objects(Track.self).filter("fastestLapDriver == nil")
    }
}

// MARK: - Migration

extension ViewController {
    
    private func updateRealm() {
        let config = Realm.Configuration(schemaVersion: 2,
                                         migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                migration.renameProperty(onType: Driver.className(), from: "status", to: "currentStatus")
            }
        })
    }
}

//
//  TableViewController.swift
//  RealmDemo
//
//  Created by Alper Kayabasi on 30.01.2022.
//

import UIKit
import RealmSwift

class TableViewController: UIViewController {
    
    private let realm = try! Realm()
    
    private let tableView = UITableView()
    
    private var listNotificationToken: NotificationToken?
    private var objectNotificationToken: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    deinit {
        listNotificationToken?.invalidate()
        objectNotificationToken?.invalidate()
    }
}

// MARK: - Observe

extension TableViewController {
    
    private func observeList() {
        let results = realm.objects(Driver.self)
        
        listNotificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.performBatchUpdates({
                    // Always apply updates in the following order: deletions, insertions, then modifications.
                    // Handling insertions before deletions may result in unexpected behavior.
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                }, completion: { finished in
                    // ...
                })
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    private func observeObject() {
        let object = realm.object(ofType: Driver.self, forPrimaryKey: "202244")!
        
        objectNotificationToken = object.observe { change in
            switch change {
            case .change(let object, let properties):
                for property in properties {
                    print("Property '\(property.name)' of object \(object) changed to '\(property.newValue!)'")
                }
            case .error(let error):
                print("An error occurred: \(error)")
            case .deleted:
                print("The object was deleted.")
            }
        }
    }
    
    private func silentWrite() {
        try! realm.write(withoutNotifying: [listNotificationToken!, objectNotificationToken!], {
            // silent write transaction
        })
    }
}

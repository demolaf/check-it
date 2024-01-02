//
//  LocalStorageImpl.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation
import RealmSwift

class LocalStorageImpl: LocalStorage {
    let realm: Realm?
    
    init() {
        self.realm = try? Realm()
        debugPrint(Realm.Configuration.defaultConfiguration.fileURL ?? "No realm path")
    }
    
    func create(object: AnyObject) -> Result<String, LocalStorageError> {
        guard let object = object as? Object else {
            debugPrint("Object is not a realm object")
            return .failure(.failedToStoreData)
        }

        do {
            try realm?.write {
                realm?.add(object, update: .all)
            }
            return .success("Object has been created in database")
        } catch {
            return .failure(.failedToStoreData)
        }
    }
    
    func read<ObjectType: AnyObject>(object: ObjectType.Type) async -> Result<ObjectType, LocalStorageError> {
        guard let object = ObjectType.self as? Object.Type else {
            return .failure(.failedToFetchData)
        }
        
        let result = realm?.object(
            ofType: object.self,
            forPrimaryKey: object.primaryKey()
        )
        
        switch result {
        case .none:
            return .failure(.failedToFetchData)
        case .some(let object):
            guard let object = object as? ObjectType else {
                return .failure(.failedToFetchData)
            }
            return .success(object)
        }
    }
    
    func readAll<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?
    ) async -> Result<[ObjectType], LocalStorageError> {
        guard let object = ObjectType.self as? Object.Type else {
            return .failure(.failedToFetchData)
        }

        var results = realm?.objects(object.self)
        if let predicate = predicate {
            results = results?.filter(predicate)
        }

        switch results {
        case .none:
            return .failure(.failedToFetchData)
        case .some(let objects):
            let mappedObjects = objects.sorted(byKeyPath: sortBy).compactMap { $0 as? ObjectType }
            return .success(Array(mappedObjects))
        }
    }
}

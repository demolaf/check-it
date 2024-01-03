//
//  LocalStorageImpl.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation
import RealmSwift

class LocalStorageImpl: LocalStorage {
    var realm: Realm?
    
    init() {
        self.realm = try? Realm()
        debugPrint(Realm.Configuration.defaultConfiguration.fileURL ?? "No realm path")
    }
    
    func create(object: AnyObject) -> Result<String, CustomDataError> {
        guard let object = object as? Object else {
            debugPrint("Object is not a realm object")
            return .failure(.failedToStoreData)
        }
        
        do {
            try realm?.write {
                realm?.add(object)
            }
            return .success("Object has been created in database")
        } catch {
            return .failure(.failedToStoreData)
        }
    }
    
    func read<ObjectType: AnyObject>(object: ObjectType.Type) -> Result<ObjectType, CustomDataError> {
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
        sortBy: String?,
        predicate: NSPredicate?
    ) -> Result<[ObjectType], CustomDataError> {
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
            var mappedObjects: [ObjectType]
            if let sortBy = sortBy {
                mappedObjects = objects.sorted(byKeyPath: sortBy).compactMap { $0 as? ObjectType }
            } else {
                mappedObjects = objects.compactMap { $0 as? ObjectType }
            }
            return .success(Array(mappedObjects))
        }
    }
    
    func delete() -> Result<String, CustomDataError> {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
            return .success("Object has been created in database")
        } catch {
            return .failure(.failedToStoreData)
        }
    }
}

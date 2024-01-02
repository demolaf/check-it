//
//  LocalStorage.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol LocalStorage {
    func create(object: AnyObject) -> Result<String, LocalStorageError>

    func read<ObjectType: AnyObject>(
        object: ObjectType.Type
    ) async -> Result<ObjectType, LocalStorageError>

    func readAll<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String,
        predicate: NSPredicate?
    ) async -> Result<[ObjectType], LocalStorageError>
}

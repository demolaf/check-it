//
//  LocalStorage.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol LocalStorage {
    func create(object: AnyObject) -> Result<String, CustomDataError>

    func read<ObjectType: AnyObject>(
        object: ObjectType.Type
    ) -> Result<ObjectType, CustomDataError>

    func readAll<ObjectType: AnyObject>(
        object: ObjectType.Type,
        sortBy: String?,
        predicate: NSPredicate?
    ) -> Result<[ObjectType], CustomDataError>
    
    func delete() -> Result<String, CustomDataError>
}

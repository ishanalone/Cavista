//
//  RealmManager.swift
//  CavistaAssignement
//
//  Created by Sushant Alone on 01/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import RealmSwift


public final class WriteTransaction {
    private let realm: Realm
    internal init(realm: Realm) {
        self.realm = realm
    }
    public func add<T: Persistable>(_ value: T) {
        realm.add(value.managedObject(), update: .all)
    }
}
// Implement the Container
public final class Container {

    private let realm: Realm
    public convenience init() throws {
        try self.init(realm: Realm())
    }
    internal init(realm: Realm) {
        self.realm = realm
    }
    public func write(_ block: (WriteTransaction) throws -> Void)
    throws {
        let transaction = WriteTransaction(realm: realm)
        try realm.write {
            try block(transaction)
        }
    }
    
    func fetchData(of classObject: Object.Type, with predicate:NSPredicate? ) -> Results<Object>{
        if let predicate = predicate{
            return self.realm.objects(classObject).filter(predicate)
        }
        return self.realm.objects(classObject)
    }
}

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

extension Persistable {
    
}

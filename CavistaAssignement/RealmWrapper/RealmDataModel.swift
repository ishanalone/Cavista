//
//  RealmDataModel.swift
//  CavistaAssignement
//
//  Created by Sushant Alone on 01/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import RealmSwift

class ItemObject : Object {
    @objc dynamic var id = 0
    @objc dynamic var dataType = ""
    @objc dynamic var date = ""
    @objc dynamic var data = ""
    @objc dynamic var imgWidth = 0.0
    @objc dynamic var imgHeight = 0.0
    @objc dynamic var isImageLoaded = true
    override static func primaryKey() -> String? {
        return "id"
    }
}


extension ObjectDataModel: Persistable {
    public init(managedObject: ItemObject) {
        id = "\(managedObject.id)"
        type = DataType(rawValue: managedObject.dataType)!
        date = managedObject.date
        data = managedObject.data
        imgWidth = managedObject.imgWidth
        imgHeight = managedObject.imgHeight
        isImageLoaded = managedObject.isImageLoaded
    }
    public func managedObject() -> ItemObject {
        let item = ItemObject()
        item.id = Int(id) ?? 0
        item.dataType = type.rawValue
        item.date = date ?? ""
        item.data = data ?? ""
        item.imgWidth = imgWidth ?? 0.0
        item.imgHeight = imgHeight ?? 0.0
        item.isImageLoaded = isImageLoaded ?? true
        return item
    }
}

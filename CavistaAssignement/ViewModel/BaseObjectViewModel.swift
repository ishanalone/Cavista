//
//  BaseObjectViewModel.swift
//  CavistaAssignement
//
//  Created by Sushant Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import UIKit

protocol Updatable {
    func updateData(with newData:[ObjectDataModel])
    func reuseIdentifier() -> String
}

class BaseObjectViewModel {
    var data = Observable<[ObjectDataModel]> (value : [])
    var collection : UICollectionView
    var type : DataType
    init(_ collectionView : UICollectionView, dataType : DataType) {
        self.collection = collectionView
        self.type = dataType
    }
    
    
}

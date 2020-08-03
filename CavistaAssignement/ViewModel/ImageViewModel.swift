//
//  ImageViewModel.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import UIKit

class  ImageViewModel : BaseObjectViewModel,Updatable{
    func updateData(with newData: [ObjectDataModel]) {
        
        var data = newData.filter{$0.type==type && $0.isImageLoaded!}
        data = data.sorted(by: { (object1, object2) -> Bool in
            return object1.getBlockHeight(collectionView: self.collection) > object2.getBlockHeight(collectionView: self.collection)
        })
        
        self.data.value = data
    }
    
    func reuseIdentifier() -> String {
        return ImageCell.cellIdentifier()
    }
}

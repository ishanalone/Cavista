//
//  TextViewModel.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation

class  TextViewModel : BaseObjectViewModel, Updatable{
    
    func updateData(with newData: [ObjectDataModel]) {
        
        let data = newData.filter{$0.type==type}
        self.data.value = data
        
    }
    
    func reuseIdentifier() -> String {
        return TextCell.cellIdentifier()
    }
}

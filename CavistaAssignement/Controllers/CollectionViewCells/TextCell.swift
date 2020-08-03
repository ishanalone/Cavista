//
//  TextCell.swift
//  CavistaAssignement
//
//  Created by Sushant Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit

class TextCell: ItemCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextCell : CollectionCellConfigurable{
    func setupInitialUI() {
        self.setupLabel()
    }
    
    func setUpModel(_ item: Item) {
        label.text = item.data
    }
    
    
}

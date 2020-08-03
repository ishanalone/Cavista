//
//  ImageCell.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCell: ItemCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension ImageCell : CollectionCellConfigurable{
    func setupInitialUI() {
        self.setupImageView()
        
        
    }
    
    func setUpModel(_ item: Item) {
        let cache = ImageCache.default
        if cache.isCached(forKey: item.data!){
            item.cachedImage { (image) in
                self.imageView.image = image
                if (image?.size.width)! < self.contentView.frame.width{
                    self.imageView.contentMode = .center
                }else{
                    self.imageView.contentMode = .scaleAspectFill
                }
            }
        }else{
            self.imageView.image = defaultImage
            self.imageView.contentMode = .scaleAspectFill
        }
        
    }
    
    
}

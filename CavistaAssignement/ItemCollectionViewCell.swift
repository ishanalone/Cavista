//
//  ItemCollectionViewCell.swift
//  CavistaAssignement
//
//  Created by Sushant Alone on 31/07/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher



class ItemCollectionViewCell: UICollectionViewCell {
    
    var imageView : UIImageView = UIImageView(frame: CGRect.zero)
    //lazy var label : UILabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
//            make.right.equalTo(rightAnchor as! ConstraintRelatableTarget)
//            make.top.equalTo(topAnchor as! ConstraintRelatableTarget)
//            make.bottom.equalTo(bottomAnchor as! ConstraintRelatableTarget)
        }
        
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
    }
    
    func setData(_ item:ItemDataModel)  {
        if item.type == .image{
            let cache = ImageCache.default
            if cache.isCached(forKey: item.id){
                item.cachedImage { (image) in
                    self.imageView.image = image
                }
            }else{
                self.imageView.image = #imageLiteral(resourceName: "Image")
            }
            
        } else {
            
        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ItemCollectionViewCell.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 31/07/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import SnapKit


protocol CollectionCellConfigurable {
    typealias Item = ObjectDataModel
    func setupInitialUI()
    func setUpModel(_ item : Item)
}

class ItemCollectionViewCell: UICollectionViewCell {
    
    var container : UIView = UIView(frame: .zero)
    var imageView : UIImageView = UIImageView(frame: CGRect.zero)
    lazy var label : UILabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        contentView.backgroundColor = .white
        container.backgroundColor = .white
        contentView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
        }
    
    }
 
    func setupImageView() {
        container.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addBorder(withBorderColor: .gray, isTransparent: false)
        imageView.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
    }
    
    func setupLabel() {
        container.addSubview(label)
        container.addBorder(withBorderColor: .gray, isTransparent: false)
        label.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
        }
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

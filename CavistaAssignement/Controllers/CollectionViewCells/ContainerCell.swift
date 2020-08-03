//
//  ContainerCell.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit

class ContainerCell: UICollectionViewCell {
    
    let containerView : UIView = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

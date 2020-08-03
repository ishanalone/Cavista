//
//  BaseCollectionLayout.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit

protocol BaseLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

protocol Editable {
    func setNumberOfColumns(_ value:Int)
}



class BaseCollectionLayout: UICollectionViewLayout {
    
    weak var delegate: BaseLayoutDelegate?

    var numberOfColumns = 2 //Default
    var cellPadding: CGFloat = 6 //Default

    var cache: [UICollectionViewLayoutAttributes] = []
   

    var contentHeight: CGFloat = 0

     var contentWidth: CGFloat {
      guard let collectionView = collectionView else {
        return 0
      }
      let insets = collectionView.contentInset
      return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        
      return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard
            cache.isEmpty,
            let _ = collectionView
            else {
                return
        }
       
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
            for attributes in cache {
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
            
            return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
    }
}

extension BaseCollectionLayout : Editable{
    func setNumberOfColumns(_ value: Int) {
        self.numberOfColumns = value
    }
}

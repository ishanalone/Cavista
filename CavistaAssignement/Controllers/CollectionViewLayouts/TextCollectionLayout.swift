//
//  TextCollectionLayout.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit

class TextCollectionLayout: BaseCollectionLayout {
    
    
    
    override func prepare() {
        super.prepare()
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        let column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        
        
        for item in 0..<collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let photoHeight = delegate?.collectionView(
                collectionView!,
                heightForPhotoAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + photoHeight
            let frame = CGRect(x: 0,
                               y: yOffset[column],
                               width: collectionView!.frame.width,
                               height: height)
            //                print("frame : \(frame)")
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            //              print("column y offset : \(yOffset[column]), column : \(column)")
        }
        
        
        
        
        
    }
    
}


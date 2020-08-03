//
//  ImagesViewController.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import SnapKit

class ImagesViewController: BaseObjectViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ImageViewModel(self.collectionView, dataType: .image)
        let layout = ImageCollectionLayout()
        layout.setNumberOfColumns(2)
        layout.delegate = self
        self.collectionView.collectionViewLayout = layout
        self.collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.cellIdentifier())
        bindData()
    }
    
    override func bindData() {
        super.bindData()
        viewModel!.data.addObserver(fireNow: false) { (itemVM) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    

}

extension ImagesViewController : BaseLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let object =  self.viewModel?.data.value[indexPath.row]
        return (object?.getBlockHeight(collectionView: collectionView))!
    }
    
}






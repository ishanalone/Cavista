//
//  TextViewController.swift
//  CavistaAssignement
//
//  Created by Sushant Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit

class TextViewController: BaseObjectViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = TextViewModel(self.collectionView, dataType: .text)
        let layout = TextCollectionLayout()
        layout.setNumberOfColumns(1)
        layout.delegate = self
        self.collectionView.collectionViewLayout = layout
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.cellIdentifier())
        bindData()
        if let model = viewModel as? Updatable{
            model.updateData(with: (baseViewModel?.data.value)!)
        }
        // Do any additional setup after loading the view.
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

extension TextViewController : BaseLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let object =  self.viewModel?.data.value[indexPath.row]
        return (object?.getBlockHeight(collectionView: collectionView))!
    }
    
    
}





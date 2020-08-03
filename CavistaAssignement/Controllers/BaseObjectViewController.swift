//
//  BaseObjectViewController.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 03/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import Kingfisher

class BaseObjectViewController: UIViewController {

    var baseViewModel : ViewModel?
    var viewModel : BaseObjectViewModel?
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.collectionViewLayout = layout
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        self.viewModel = BaseObjectViewModel(self.collectionView, dataType: .image)
        self.view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        self.bindData()
        // Do any additional setup after loading the view.
    }
    
    func bindData()  {
        baseViewModel!.data.addObserver(fireNow: false) { (itemVM) in
            DispatchQueue.main.async {
                if let data = self.baseViewModel?.data.value{
                    if let model = self.viewModel as? Updatable{
                        model.updateData(with: data)
                    }
                }
                
            }
        }
        
        
    }
}

extension BaseObjectViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let parent = self.parent as? ViewController{
            if viewModel?.type == .image{
                let vc = FullImageViewController()
                if let object = viewModel?.data.value[indexPath.row]{
                    let cache = ImageCache.default
                    if cache.isCached(forKey: object.data ?? ""){
                        object.cachedImage { (image) in
                            vc.imageView.image = image
                        }
                    }else{
                        vc.imageView.image = defaultImage
                    }
                    vc.object = object
                }
                parent.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = FullTextViewController()
                let object = viewModel?.data.value[indexPath.row]
                vc.object = object
                parent.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension BaseObjectViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var reuseIdentifier = ImageCell.cellIdentifier()
        if let model = viewModel as? Updatable{
            reuseIdentifier = model.reuseIdentifier()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier , for: indexPath)
        let item = viewModel!.data.value[indexPath.row]
        if let cell = cell as? CollectionCellConfigurable{
            cell.setUpModel(item)
        }

        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = viewModel{
           return viewModel.data.value.count
        }
        return 0
    }
    
    
    
    
}

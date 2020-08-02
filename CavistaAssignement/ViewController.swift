//
//  ViewController.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 31/07/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let homeViewModel : HomeViewModel = HomeViewModel()
    
    var sizeArray : [CGSize]?
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.collectionViewLayout = layout
        collection.backgroundColor = .green
        return collection
    }()
    
    lazy var segmentControl : UISegmentedControl = {
        let segment = UISegmentedControl(frame: .zero)
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.cellIdentifier())
        
        bindData()
        homeViewModel.getHomeData()
        //homeViewModel.fetchFromRealm(with: "image")
        // Do any additional setup after loading the view.
    }

    override func updateViewConstraints() {
        
        super.updateViewConstraints()
    }
    
    func getCellSize(with imagesSize:CGSize) -> CGSize {
        if imagesSize.height > 0 && imagesSize.width > 0{
            let mainWidth = UIScreen.main.bounds.size.width - 20
            var width = CGFloat(exactly: 0.0)
            if imagesSize.width > imagesSize.height{
                width = (mainWidth - 40) / 2
            }else {
                width = (mainWidth - 40 ) / 2
            }
            let height = (imagesSize.height*width!)/imagesSize.width
            let size = CGSize(width: width!, height: height)
            print(size)
            return size
        }
        return .zero
    }
    
    func bindData()  {
        homeViewModel.homeData.addObserver(fireNow: false) { (itemVM) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.homeData.value.filter{$0.type == .image}.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.cellIdentifier(), for: indexPath) as! ItemCollectionViewCell
        let item = homeViewModel.homeData.value[indexPath.row]
        cell.setData(item)
        return cell
    }
    
    
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = homeViewModel.homeData.value[indexPath.row]
        if item.type == .image{
            let size = CGSize(width: item.imgWidth ?? 0.0, height: item.imgHeight ?? 0.0)
            return getCellSize(with: size) 
        }
        return .zero
    }
}

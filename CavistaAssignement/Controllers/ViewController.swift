//
//  ViewController.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 31/07/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import SnapKit
import Reachability
class ViewController: UIViewController {
   
    var viewModel : ViewModel?

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.collectionViewLayout = layout
        collection.backgroundColor = .white
        return collection
    }()
    
    lazy var segmentControl : UISegmentedControl = {
        let segmentItems = ["Image", "Text"]
        let segment = UISegmentedControl(items: segmentItems)
        return segment
    }()
    
    let imageVC : ImagesViewController = ImagesViewController()
    let textVC : TextViewController = TextViewController()
    var reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupSegmentControl()
        
        self.view.backgroundColor = UIColor.white
        self.viewModel = ViewModel()
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentControl.snp.bottom).offset(5)
            make.leading.equalTo(self.view.snp.leading).offset(5)
            make.trailing.equalTo(self.view.snp.trailing).offset(-5)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        initialiseTextVC()
        initialiseImageVC()
    
        collectionView.register(ContainerCell.self, forCellWithReuseIdentifier: ContainerCell.cellIdentifier())
        
        bindData()
        checkReachability()

    }
    
    func checkReachability() {
        reachability = try! Reachability()
        reachability.whenReachable = { reachability in
            self.viewModel!.getData()
        }
        reachability.whenUnreachable = { _ in
            
            self.viewModel?.fetchOfflineData()
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func setupSegmentControl() {
        self.view.addSubview(segmentControl)
        self.segmentControl.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalTo(self.view.snp.leading).offset(5)
            make.trailing.equalTo(self.view.snp.trailing).offset(-5)
            make.height.equalTo(40)
        }
        self.segmentControl.selectedSegmentIndex = 0
        self.segmentControl.addTarget(self, action: #selector(segmentValueChange(_:)), for: .valueChanged)
        
    }
    
    
    @objc func segmentValueChange(_ segmentedControl: UISegmentedControl) {
        self.collectionView.scrollToItem(at: IndexPath(row: segmentControl.selectedSegmentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func initialiseImageVC() {
        self.addChild(imageVC)
        imageVC.baseViewModel = viewModel
        imageVC.didMove(toParent: self)
    }
    
    func initialiseTextVC() {
        self.addChild(textVC)
        textVC.baseViewModel = viewModel
        textVC.didMove(toParent: self)
    }

    override func updateViewConstraints() {
        
        super.updateViewConstraints()
    }
    
    
    
    func bindData()  {
        viewModel!.data.addObserver(fireNow: false) { (itemVM) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        viewModel!.isLoading.addObserver {[weak self] isLoading in
            DispatchQueue.main.async {
                if (isLoading){
                    self?.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
                        self?.collectionView.isHidden = true
                }
                else{
                    self?.view.activityStopAnimating()
                    self?.collectionView.isHidden = false
                }
            }
        }
    }
}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContainerCell.cellIdentifier(), for: indexPath) as! ContainerCell
        if indexPath.row == 0{
            cell.containerView.addSubview(imageVC.view)
            imageVC.view.snp.makeConstraints { (make) in
                make.top.bottom.leading.trailing.equalToSuperview()
            }
        }else{
            cell.containerView.addSubview(textVC.view)
            textVC.view.snp.makeConstraints { (make) in
                make.top.bottom.leading.trailing.equalToSuperview()
            }
        }
        return cell
    }
    
    
}

extension ViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        segmentControl.selectedSegmentIndex = indexPath.row
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

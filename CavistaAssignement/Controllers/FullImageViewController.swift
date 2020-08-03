//
//  FullImageViewController.swift
//  CavistaAssignement
//
//  Created by Sushant Alone on 04/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit
import Kingfisher

class FullImageViewController: UIViewController {
    
    var imageView: UIImageView = UIImageView(frame: CGRect.zero)
    var object : ObjectDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(imageView)
        initilizeImageView()
        // Do any additional setup after loading the view.
    }
    
    func initilizeImageView () {
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        if let image = imageView.image{
            if image.size.width < view.frame.width &&  image.size.height < view.frame.height - 100{
                imageView.contentMode = .center
            }
        }
        if let object = object{
            self.navigationItem.title = object.date
        }
        
    }
    
    
}

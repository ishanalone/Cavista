//
//  FullTextViewController.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 04/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import UIKit


class FullTextViewController: UIViewController {
    
    var textView: UITextView = UITextView(frame: CGRect.zero)
    var object : ObjectDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textView)
        initializeTextView()
    }
    
    func initializeTextView()  {
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        textView.textAlignment = .center
        view.backgroundColor = .white
        textView.contentOffset = .zero
        textView.isEditable = false
        
        if let object = object{
            textView.text = object.data
            self.navigationItem.title = object.date
        }
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  HomeViewModel.swift
//  CavistaAssignement
//
//  Created by Sushant Alone on 01/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import Kingfisher
import RealmSwift

class HomeViewModel {
    var homeData = Observable<[ItemDataModel]> (value : [])
    let container : Container = try! Container()
    var imageCounter = 0
    func getHomeData() {
        homeData.value = []
        APIClient.getHomeData { (dataModel) in
            switch dataModel{
            case .success(let homeResponse):
                print(homeResponse)
                self.updateRealm(homeResponse)
                //self.buildHomeViewModel(homeResponse: homeResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
     func updateRealm(_ itemArray:[ItemDataModel]) {
        let totalImages = itemArray.filter{$0.type == .image}.count
        for item in itemArray{
            var tempItem = item
            tempItem.downloadAndSaveImage {  size in
                
                tempItem.imgWidth = Double(size.width)
                tempItem.imgHeight = Double(size.height)
                try! self.container.write { transaction in
                    transaction.add(tempItem)
                }
                
                self.imageCounter = self.imageCounter + 1
                if self.imageCounter == totalImages{
                    self.fetchFromRealm(with: "image")
                }
                
                
            }
            
        }
        
    }
    
    func fetchFromRealm(with type:String){
        let predicate = NSPredicate(format: "dataType == %@", type)
        let itemObjects = self.container.fetchData(with: predicate, classObject: ItemObject.self)
        var tempArr : [ItemDataModel] = []
        for itemObject in itemObjects {
            let item = ItemDataModel(managedObject: itemObject as! ItemObject)
            tempArr.append(item)
        }
        homeData.value = tempArr
    }

}



struct ItemDataModel : Codable {
    let id : String
    let type : DataType
    let date : String?
    let data : String?
    var imgWidth : Double?
    var imgHeight : Double?
    
    
    func getImageUrl() ->URL?{
        if let image = self.data {
            return URL.init(string:image)
        }
        return nil
    }
    
    func downloadAndSaveImage(_ afterDownload : @escaping (CGSize) -> Void) {
        if let url = getImageUrl(){
            let cache = ImageCache.default
            if !cache.isCached(forKey: id){
                KingfisherManager.shared.downloader.downloadTimeout = 600
                KingfisherManager.shared.retrieveImage(with: url) { (result) in
                    switch result {
                    case .success(let value):
                        cache.store(value.image, forKey: self.id)
                        print("Image size : \(value.image.size)")
                        afterDownload(value.image.size)
                        
                    case .failure(let error):
                        let mainWidth = UIScreen.main.bounds.size.width - 20
                        let defaultSize = CGSize(width: mainWidth/2, height: mainWidth/2)
                        
                        afterDownload(defaultSize)
                        print(error)
                        
                    }
                    
                }
                
            }else{
                if type == .image{
                    cachedImage { (image) in
                        if let image = image {
                            afterDownload(image.size)
                        }else{
                            let mainWidth = UIScreen.main.bounds.size.width - 20
                            let defaultSize = CGSize(width: mainWidth/2, height: mainWidth/2)
                            afterDownload(defaultSize)
                        }
                        
                    }
                }else{
                    afterDownload(.zero)
                }
                
            }
            
        }
        
    }
    
    func cachedImage(_ afterCompletion : @escaping (UIImage?)->Void){
       let cache = ImageCache.default
        cache.retrieveImage(forKey: id) { (result) in
            switch result {
            case .success(let value):
                afterCompletion(value.image)
                print("success")
            case .failure(let error):
                afterCompletion(#imageLiteral(resourceName: "Image"))
                print(error)
                
            }
        }
    }
}

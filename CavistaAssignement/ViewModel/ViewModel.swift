//
//  SuperViewModel.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 01/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import Kingfisher
import RealmSwift

class ViewModel {
    var data = Observable<[ObjectDataModel]> (value : [])
    let container : Container = try! Container()
    var imageCounter = 0
    var isLoading = Observable<Bool> (value: false)
    
    func getData() {
        ImageCache.default.clearDiskCache()
        data.value = []
        isLoading.value = true
        APIClient.getHomeData { (dataModel) in
            switch dataModel{
            case .success(let response):
                self.writeRealm(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
     func writeRealm(_ objects:[ObjectDataModel]) {
         let totalImages = objects.filter{$0.type == .image}.count
         for object in objects{
             var tempItem = object
             switch tempItem.type {
             case .image:
                tempItem.downloadAndSaveImage {  (size,isLoaded)  in
                     tempItem.imgWidth = Double(size.width)
                     tempItem.imgHeight = Double(size.height)
                    tempItem.isImageLoaded = isLoaded
                     try! self.container.write { transaction in
                         transaction.add(tempItem)
                     }
                     self.imageCounter = self.imageCounter + 1
                     if self.imageCounter == totalImages{
                         self.isLoading.value = false
                        let data = self.fetchFromRealm(nil)
                        self.data.value = data
                     }
                 }
                 
             case .text:
                 if let itemData = object.data, itemData.count > 0, let _ = object.date {
                 try! self.container.write { transaction in
                     transaction.add(tempItem)
                     }
                 }
             default:
                 print("")
             }
             
         }
         
     }
    
    func fetchOfflineData() {
        let data = self.fetchFromRealm(nil)
        self.data.value = data
    }
    
    func fetchFromRealm(_ type:DataType?) -> [ObjectDataModel]{
        var predicate : NSPredicate?
        if let type = type{
            predicate = NSPredicate(format: "dataType == %@", type.rawValue)
        }
        let itemObjects = self.container.fetchData(of: ItemObject.self, with: predicate)
        var tempArr : [ObjectDataModel] = []
        for itemObject in itemObjects {
            let item = ObjectDataModel(managedObject: itemObject as! ItemObject)
            tempArr.append(item)
        }
        return tempArr
    }

}

extension ObjectDataModel{
    func getImageUrl() ->URL?{
        if let image = self.data {
            return URL.init(string:image)
        }
        return nil
    }
    
    func getBlockHeight(collectionView : UICollectionView) -> CGFloat {
        let insets = collectionView.contentInset
        let width =  (collectionView.bounds.width  - (insets.left + insets.right))/2
        switch type {
        case .image:
            let height = (CGFloat(imgHeight ?? 0.0))*(width/CGFloat(imgWidth ?? 0.0))
            return  height
        default:
            return width
        }

    }
    
    func downloadAndSaveImage(_ afterDownload : @escaping (CGSize,Bool) -> Void) {
            if let url = getImageUrl(){
                let cache = ImageCache.default
                    KingfisherManager.shared.downloader.downloadTimeout = 600
                    KingfisherManager.shared.retrieveImage(with: url) { (result) in
                        switch result {
                        case .success(let value):
                            cache.store(value.image, forKey: self.data ?? "")
                            afterDownload(value.image.size,true)
                            
                        case .failure(let error):
                            afterDownload(defaultImage.size,false)
                            print(error)
                            
                        }
                        
                    }
            }
            
    }
    
    func cachedImage(_ afterCompletion : @escaping (UIImage?)->Void){
       let cache = ImageCache.default
        cache.retrieveImage(forKey: data ?? "") { (result) in
            switch result {
            case .success(let value):
                afterCompletion(value.image)
            case .failure(let error):
                afterCompletion(defaultImage)
                print(error)
                
            }
        }
    }
    
}

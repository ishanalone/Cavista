//
//  DataModel.swift
//  CavistaAssignement
//
//  Created by Ishan Alone on 01/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation
import Kingfisher


struct ObjectDataModel : Codable {
    let id : String
    let type : DataType
    let date : String?
    let data : String?
    var imgWidth : Double?
    var imgHeight : Double?
    var isImageLoaded : Bool?
}


    
    

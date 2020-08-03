//
//  Constants.swift
//
//  Created by Sushant Alone on 14/06/20.
//  Copyright © 2020 Sushant Alone. All rights reserved.
//

import Foundation
import UIKit

let activityBackgroundViewTag = 475647

enum DataType : String, Codable {
    case image = "image"
    case text = "text"
    case other = "other"
}


struct Constants {
    struct HomeAPIParameter {
        static let type = "type"
    }
    
}


enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case urlEncoded = "application/x-www-form-urlencoded"
}


let baseUrlPath = "http://ec2-3-134-99-218.us-east-2.compute.amazonaws.com:9444"

let defaultImage = #imageLiteral(resourceName: "Image")

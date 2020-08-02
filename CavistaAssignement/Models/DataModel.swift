//
//  DataModel.swift
//  CavistaAssignement
//
//  Created by Sushant Alone on 01/08/20.
//  Copyright © 2020 Ishan Alone. All rights reserved.
//

import Foundation

struct DataModel  {
    let data : [HomeData]?
}

struct HomeData : Codable {
    let id: String?
    let type : String?
    let date : String?
    let data : String?
}

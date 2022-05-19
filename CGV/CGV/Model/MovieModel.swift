//
//  MovieModel.swift
//  CGV
//
//  Created by RooZin on 2022/05/13.
//

import Foundation

struct Movie : Decodable {
    let items : [ItemList]
}

struct ItemList : Decodable {
    let title : String
    let link : String
    let image : String
}

//
//  Product.swift
//  CarrotMarket
//
//  Created by RooZin on 2022/04/30.
//

import Foundation

struct Product {
    let productImage : String?
    let productName : String?
    let address : String?
    let productPrice : String?
    
    init(productImage  : String, productName : String, address : String, productPrice : String) {
        self.productImage = productImage
        self.productName = productName
        self.address = address
        self.productPrice = productPrice
    }
}


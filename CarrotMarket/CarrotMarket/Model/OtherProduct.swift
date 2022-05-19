//
//  OtherProduct.swift
//  CarrotMarket
//
//  Created by RooZin on 2022/04/30.
//

import Foundation

struct OtherProduct {
    let productImage : String?
    let productName : String?
    let productPrice : String?
    
    init(productImage  : String, productName : String, productPrice : String) {
        self.productImage = productImage
        self.productName = productName
        self.productPrice = productPrice
    }
}

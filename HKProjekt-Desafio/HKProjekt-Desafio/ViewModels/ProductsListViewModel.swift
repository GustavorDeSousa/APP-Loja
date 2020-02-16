//
//  ProductsListViewModel.swift
//  HKProjekt-Desafio
//
//  Created by Gustavo De Sousa on 16/02/20.
//  Copyright © 2020 Gustavo De Sousa. All rights reserved.
//

import Foundation

class ProductsListViewModel {
    var listProducts : ProductDTO?
    var productSelected : ProductValuesDTO?
    
    var productDetail : ProductDetailDTO?
    
    func getListProducts(succes: @escaping() -> Void) {
        REST.loadListProducts { (response) in
            self.listProducts = response
            succes()
        }
    }
    
    func getDetailProduct(succes: @escaping() -> Void) {
        REST.loadDetailProducts { (response) in
            self.productDetail = response
            succes()
        }
    }
}

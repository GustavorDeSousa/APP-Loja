//
//  ProductsDetailsController.swift
//  HKProjekt-Desafio
//
//  Created by Gustavo De Sousa on 16/02/20.
//  Copyright © 2020 Gustavo De Sousa. All rights reserved.
//

import UIKit

class ProductsDetailsController: UIViewController {
    var viewModel : ProductsListViewModel?
    var indexImageProduct = 0
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbTitleProduct: UILabel!
    
    class func create(viewModel: ProductsListViewModel) -> ProductsDetailsController {
        let controller = ProductsDetailsController(nibName: "ProductsDetailsController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.getDetailProduct(succes: {
            DispatchQueue.main.async {
                self.setValuesInScreen()
            }
        })
    }
    
    func setValuesInScreen() {
        guard let product = viewModel?.productDetail else { return }
        self.imgProduct.downloaded(from: product.modelo.padrao.imagens.first?.url ?? "")
        self.lbTitleProduct.text = product.nome
    }

    @IBAction func btNextImage(_ sender: Any) {
        guard let product = viewModel?.productDetail else { return }
        if product.modelo.padrao.imagens.count == indexImageProduct + 1{
            self.indexImageProduct = 0
        } else {
            self.indexImageProduct += 1
        }
        self.imgProduct.downloaded(from: product.modelo.padrao.imagens[indexImageProduct].url )
    }
    
    @IBAction func btPreviousImage(_ sender: Any) {
        guard let product = viewModel?.productDetail else { return }
        if indexImageProduct == 0 {
            self.indexImageProduct = 4
        } else {
            self.indexImageProduct -= 1
        }
        self.imgProduct.downloaded(from: product.modelo.padrao.imagens[indexImageProduct].url )
    }
}

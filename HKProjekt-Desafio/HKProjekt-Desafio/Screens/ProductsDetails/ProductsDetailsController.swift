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
            print("teste")
        })
        // Do any additional setup after loading the view.
    }

}

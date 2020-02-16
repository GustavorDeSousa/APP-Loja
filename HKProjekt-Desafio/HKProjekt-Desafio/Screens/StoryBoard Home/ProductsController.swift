//
//  ProductsController.swift
//  HKProjekt-Desafio
//
//  Created by Gustavo De Sousa on 15/02/20.
//  Copyright © 2020 Gustavo De Sousa. All rights reserved.
//

import UIKit

class ProductsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var productsCollection: UICollectionView!
    @IBOutlet weak var btnLayoutList: UIButton!
    @IBOutlet weak var btnSquareList: UIButton!
    @IBOutlet weak var lbQtdProducts: UILabel!
    
    var viewModel = ProductsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Smart TV"
        
        self.productsCollection.register(UINib(nibName: String(describing: ProductsCollectionCell.self), bundle: nil), forCellWithReuseIdentifier: "ProductsCollectionCell")
        self.productsCollection.delegate = self
        self.productsCollection.dataSource = self
        
        self.view.backgroundColor = ColorPallete.COLOR_APP_TABBAR
        self.navigationItem.setRightBarButtonItems([btFilter], animated: true)

        setColorButton(button: btnLayoutList)
        setColorButton(button: btnSquareList)
        
        viewModel.getListProducts {
            DispatchQueue.main.async {
                self.productsCollection.reloadData()
                self.lbQtdProducts.text = String(self.viewModel.listProducts?.quantidade ?? 0) + " Ofertas"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createSizeCollectionCell(isList: false)
    }
    
    fileprivate lazy var btFilter : UIBarButtonItem = {
        var button  = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(clickFilter))
        return button

    }()
    
    @objc fileprivate func clickFilter() {

    }
    
    func setColorButton(button: UIButton) {
        button.tintColor = ColorPallete.COLOR_APP_BLUE
    }
    
    func createSizeCollectionCell(isList: Bool) {
        let layout = UICollectionViewFlowLayout()
        if isList {
            let cellSize = CGSize(width:self.view.frame.width, height:self.view.frame.height/2.5)
            layout.scrollDirection = .vertical
            layout.itemSize = cellSize
            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
            layout.minimumLineSpacing = 1.0
            layout.minimumInteritemSpacing = 1.0
        } else {
            let cellSize = CGSize(width:self.view.frame.width / 2 , height:self.view.frame.height / 2)
            layout.scrollDirection = .vertical
            layout.itemSize = cellSize
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        productsCollection.setCollectionViewLayout(layout, animated: true)
        productsCollection.reloadData()

    }
    
    func generateRatingStar(cell: ProductsCollectionCell, ratingValue: Int) {
        if ratingValue >= 1 { cell.rating1.image = UIImage(systemName: "star.fill")}
        if ratingValue >= 2 { cell.rating2.image = UIImage(systemName: "star.fill")}
        if ratingValue >= 3 { cell.rating3.image = UIImage(systemName: "star.fill")}
        if ratingValue >= 4 { cell.rating4.image = UIImage(systemName: "star.fill")}
        if ratingValue == 5 { cell.rating5.image = UIImage(systemName: "star.fill")}
    }
    
    @IBAction func clickListLayout(_ sender: Any) {
        self.createSizeCollectionCell(isList: true)
    }
    
    @IBAction func clickSquareLayout(_ sender: Any) {
        self.createSizeCollectionCell(isList: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listProducts?.produtos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCollection.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionCell", for: indexPath) as! ProductsCollectionCell
        if let produto = viewModel.listProducts?.produtos[indexPath.row] {
            cell.imgProduct.downloaded(from: produto.imagemUrl)
            cell.lbTitleProduct.text = produto.nome
            cell.lbValueFull.text = "R$ " + String(produto.preco.precoAnterior)
            cell.lbValue.text = "R$ " + String(produto.preco.precoAtual)
            cell.lbPortionValue.text = produto.preco.planoPagamento
            generateRatingStar(cell: cell, ratingValue: produto.classificacao)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.productSelected = viewModel.listProducts?.produtos[indexPath.row]
        self.navigationController?.pushViewController(ProductsDetailsController.create(viewModel: viewModel), animated: true)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

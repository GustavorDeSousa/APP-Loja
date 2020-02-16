//
//  ProductsDetailsController.swift
//  HKProjekt-Desafio
//
//  Created by Gustavo De Sousa on 16/02/20.
//  Copyright © 2020 Gustavo De Sousa. All rights reserved.
//

import UIKit

class ProductsDetailsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var viewModel : ProductsListViewModel?
    var indexImageProduct = 0
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbTitleProduct: UILabel!
    @IBOutlet weak var btLikeProduct: UIButton!
    @IBOutlet weak var lbCod: UILabel!
    
    @IBOutlet weak var lbValueAntigo: UILabel!
    @IBOutlet weak var lbValueActual: UILabel!
    @IBOutlet weak var vwBackgroundDiscount: UIView!
    @IBOutlet weak var lbDiscount: UILabel!
    @IBOutlet weak var lbParcelas: UILabel!
    
    @IBOutlet weak var vwBackgroundContrato: UIView!
    @IBOutlet weak var lbContratoTitle: UILabel!
    @IBOutlet weak var lbContratoValue: UILabel!
    @IBOutlet weak var btnComprar: UIButton!
    @IBOutlet weak var btnCarFrete: UIButton!
    
    @IBOutlet weak var lbVendidoPor: UILabel!
    @IBOutlet weak var lbTambemVendidoPor: UILabel!
    @IBOutlet weak var btnCarVendidoPor: UIButton!
    @IBOutlet weak var lbDescricaoProduto: UILabel!
    
    @IBOutlet weak var cvQuemViuComprou: UICollectionView!
    
    class func create(viewModel: ProductsListViewModel) -> ProductsDetailsController {
        let controller = ProductsDetailsController(nibName: "ProductsDetailsController", bundle: nil)
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detalhes do produto"
        
        self.cvQuemViuComprou.register(UINib(nibName: String(describing: ProductsCollectionCell.self), bundle: nil), forCellWithReuseIdentifier: "ProductsCollectionCell")
        self.cvQuemViuComprou.delegate = self
        self.cvQuemViuComprou.dataSource = self

        btLikeProduct.backgroundColor = ColorPallete.COLOR_APP_BUTTON_GRAY
        self.setCornerRadius(cornerRound: true, button: btLikeProduct)
        self.setCornerRadius(cornerRound: true, view: vwBackgroundDiscount)
        self.setCornerRadius(cornerRound: false,corner: 10, view: vwBackgroundContrato)
        self.setCornerRadius(cornerRound: false,corner: 10, view: btnComprar)
        self.setCornerRadius(cornerRound: false,corner: 10, view: btnCarFrete)
        self.setCornerRadius(cornerRound: false,corner: 10, view: btnCarVendidoPor)
        
        self.setBorder(heigth: 1, color: UIColor.lightGray, label: lbVendidoPor)
        self.setBorder(heigth: 1, color: UIColor.lightGray, label: lbTambemVendidoPor)


        viewModel?.getDetailProduct(succes: {
            DispatchQueue.main.async {
                self.setValuesInScreen()
            }
        })
        
        self.viewModel?.getLoadQuemViu(succes: {
            DispatchQueue.main.async {
                self.cvQuemViuComprou.reloadData()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.createSizeCollectionCell()
        }
    }
    
    func createSizeCollectionCell() {
        let layout = UICollectionViewFlowLayout()
        let cellSize = CGSize(width: 160, height: 300)
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        cvQuemViuComprou.setCollectionViewLayout(layout, animated: true)
        cvQuemViuComprou.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.quemViuDTO?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvQuemViuComprou.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionCell", for: indexPath) as! ProductsCollectionCell

        cell.imgProduct.downloaded(from: viewModel?.quemViuDTO?[indexPath.row].imagemUrl ?? "")
        cell.lbTitleProduct.text = viewModel?.quemViuDTO?[indexPath.row].nome
        return cell
    }
}

extension ProductsDetailsController {
    func setValuesInScreen() {
        guard let product = viewModel?.productDetail else { return }
        self.imgProduct.downloaded(from: product.modelo.padrao.imagens.first?.url ?? "")
        self.lbTitleProduct.text = product.nome
        self.lbCod.text = "Cód. item " + String(product.modelo.padrao.sku)
        
        self.lbValueAntigo.text = "R$ " + String(product.modelo.padrao.preco.precoAnterior)
        self.lbValueActual.text = "R$ " + String(product.modelo.padrao.preco.precoAtual)
        self.lbDiscount.text = "- " + String(product.modelo.padrao.preco.porcentagemDesconto) + "%"
        self.lbParcelas.text = "Ou em até " + String(product.modelo.padrao.preco.planoPagamento)
        
        self.lbContratoTitle.text = String(product.modelo.padrao.servicos.first?.nome ?? "")
        self.lbContratoValue.text = String(product.modelo.padrao.servicos.first?.parcelamento ?? "")
        
        self.lbVendidoPor.text = String(product.modelo.padrao.marketplace.lojistaPadrao.nome)
        self.lbTambemVendidoPor.text = String(product.modelo.padrao.marketplace.lojistasEmDestaque.first?.nome ?? "")
        self.lbDescricaoProduto.text = product.descricao
    }
    
    func setBorder(heigth: Int, color: UIColor, label: UILabel? = nil) {
        if label != nil {
            label?.layer.borderColor = color.cgColor
            label?.layer.borderWidth = CGFloat(heigth)
        }
    }
    
    func setCornerRadius(cornerRound: Bool, corner: Int? = nil, button: UIButton? = nil, view: UIView? = nil) {
        if button != nil {
            if cornerRound {
                button?.layer.cornerRadius = (button?.frame.height ?? 0) / 2
                button?.layer.masksToBounds = true
            } else {
                button?.layer.cornerRadius = CGFloat(corner ?? 0)
                button?.layer.masksToBounds = true
            }
        } else if view != nil {
            if cornerRound {
                view?.layer.cornerRadius = (view?.frame.height ?? 0) / 2
                view?.layer.masksToBounds = true
            } else {
                view?.layer.cornerRadius = CGFloat(corner ?? 0)
                view?.layer.masksToBounds = true
            }
        }
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
            self.indexImageProduct = product.modelo.padrao.imagens.count - 1
        } else {
            self.indexImageProduct -= 1
        }
        self.imgProduct.downloaded(from: product.modelo.padrao.imagens[indexImageProduct].url )
    }
}

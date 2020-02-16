//
//  ProductDTO.swift
//  HKProjekt-Desafio
//
//  Created by Gustavo De Sousa on 16/02/20.
//  Copyright © 2020 Gustavo De Sousa. All rights reserved.
//

import Foundation

class ProductDTO: Codable {
    var produtos : [ProductValuesDTO]
    var quantidade : Int
}

class ProductValuesDTO: Codable {
    var id : Int
    var sku : Int
    var nome : String
    var disponivel : Bool
    var descricao: String
    var imagemUrl: String
    var classificacao: Int
    var preco : ProductTypePay
}

class ProductTypePay: Codable {
    var planoPagamento : String
    var valorParcela: Double
    var quantidadeMaximaParcelas: Int
    var precoAtual: Double
    var precoAnterior : Double
    var porcentagemDesconto : Double
}

class ProductDetailDTO: Codable {
    var id : Int
    var nome : String
    var descricao : String
    var retiraEmLoja : Bool
//    var categorias : [CategoriasTVDTO]
//    var maisInformacoes : [MoreDetailProductDTO]
//    var marca : ProducerDTO
//    var modelo : ModelProduct
    var urlVideo : String
}

class ModelProduct: Codable {
//    var skus : [Any] = []
    var padrao : PatternProductDTO
}

class PatternProductDTO: Codable {
    var sku : Int
    var nome : String
    var disponivel: Bool
    var marketplace : MarketplaceDTO
    var preco : ProductPreco
    
}

class ProductPreco: Codable {
    var planoPagamento : String
    var valorParcela : Double
    var quantidadeMaximaParcelas : Int
    var precoAtual : Double
    var precoAnterior : Double
    var porcentagemDesconto : Int
    var descontoFormaPagamento : DescontoFormaPagamentoDTO
    var imagens : ImageProductDTO
    var servicos: ServiceProductsDTO
}

class ServiceProductsDTO: Codable {
    var nome : String
    var sku : Int
    var idLojista : Int
    var preco : Int
    var parcelamento : String
    var tipo : String
}

class ImageProductDTO: Codable {
    var id : Int
    var nome : String
    var altura : Int
    var largura : Int
    var url : String
}

class DescontoFormaPagamentoDTO: Codable {
    var preco : Double
    var possuiDesconto : Bool
    var descricao : String
    var porcentagemDesconto : Int
}

class MarketplaceDTO: Codable {
    var maiorPreco : Double
    var menorPreco : Double
    var lojistaPadrao : LojistaDTO
    var lojistasEmDestaque : LojistaDTO
}

class LojistaDTO: Codable {
    var id : Int
    var nome : String
    var preco : Int
    var retiraRapido : Bool
    var compraOnline: Bool
    var eleito: Bool
}

class ProducerDTO: Codable {
    var id : Int
    var nome : String
}

class CategoriasTVDTO: Codable {
    var id : Int
    var descricao : String
}

class MoreDetailProductDTO: Codable {
    var descricao : String
    var valores : [MoreDetailValuesDTO]
}

class MoreDetailValuesDTO: Codable {
    var nome : String
    var valor : String
}


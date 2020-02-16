//
//  REST.swift
//  HKProjekt-Desafio
//
//  Created by Gustavo De Sousa on 16/02/20.
//  Copyright © 2020 Gustavo De Sousa. All rights reserved.
//

import Foundation

class REST {
    private static let configuration: URLSessionConfiguration = {
        let config =  URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadListProducts(succes: @escaping(ProductDTO) -> Void) {
        guard let url = URL(string: APPURL.LIST_PRODUCT) else { return }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, erro: Error?) in
            if erro == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let products = try JSONDecoder().decode(ProductDTO.self, from: data)
                        succes(products)

                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Algum status invalido")
                }
            } else {
                print(erro!)
            }
        }
        dataTask.resume()
    }
    
    class func loadDetailProducts(succes: @escaping(ProductDetailDTO) -> Void) {
        guard let url = URL(string: APPURL.DETAIL_PRODUCT) else { return }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, erro: Error?) in
            if erro == nil {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 200 {
                    guard let data =  data else { return }
                    do {
                        let products = try JSONDecoder().decode(ProductDetailDTO.self, from: data)
                        succes(products)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Algum status invalido")
                }
            } else {
                print(erro!)
            }
        }
        dataTask.resume()
    }
}

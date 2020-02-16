//
//  CollectionViewCell.swift
//  HKProjekt-Desafio
//
//  Created by Gustavo De Sousa on 15/02/20.
//  Copyright © 2020 Gustavo De Sousa. All rights reserved.
//

import UIKit

class ProductsCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbTitleProduct: UILabel!
    @IBOutlet weak var lbValueFull: UILabel!
    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbPortionValue: UILabel!
    
    @IBOutlet weak var rating1: UIImageView!
    @IBOutlet weak var rating2: UIImageView!
    @IBOutlet weak var rating3: UIImageView!
    @IBOutlet weak var rating4: UIImageView!
    @IBOutlet weak var rating5: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorPallete.COLOR_APP_BUTTON_GRAY.cgColor
        
        
    }

}

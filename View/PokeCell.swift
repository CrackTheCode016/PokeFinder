//
//  PokeCell.swift
//  PokeFinder
//
//  Created by Santiago on 10/30/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeName: UILabel!
    
    @IBOutlet weak var pokeImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    func updateCellUI(pokemodel: Pokemon) {
        pokeName.text = pokemodel.name
        pokeImage.image = UIImage(named: "\(pokemodel.pokeID)")
        
        
    }
    
}

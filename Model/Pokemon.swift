//
//  Pokemon.swift
//  PokeFinder
//
//  Created by Santiago on 10/30/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import Foundation


class Pokemon {
    
    private var _name: String!
    private var _pokeID: Int!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        
        return _name
    }
    
    
    var pokeID: Int {
        if _pokeID == nil {
            _pokeID = 0
        }
        
        return _pokeID
    }
    
    init(name: String, pokeID: Int) {
        self._name = name
        self._pokeID = pokeID
        
    }
}

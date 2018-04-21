//
//  PokeCollectionViewVC.swift
//  PokeFinder
//
//  Created by Santiago on 10/29/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import UIKit

class PokeCollectionViewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    var pokeArray = [Pokemon]()
    var filteredPokeArray = [Pokemon]()
    var searchModeIsOn: Bool = false
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    
    @IBOutlet var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        addPokemon()
        pokeSearchBar.delegate = self

    }
    
    func addPokemon() {
        for i in 0..<pokemon.count {
             let poke = Pokemon(name: pokemon[i].capitalized, pokeID: i + 1)
                pokeArray.append(poke)


        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchModeIsOn == true {
            return filteredPokeArray.count
        }
        return pokeArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchBar.text == "" || searchBar.text == nil {
            searchModeIsOn = false
            collectionView.reloadData()

        }
        
        else {
            searchModeIsOn = true
            filteredPokeArray = pokeArray.filter({$0.name.range(of: searchBar.text!) != nil})
            collectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            if searchModeIsOn == true {
                cell.updateCellUI(pokemodel: filteredPokeArray[indexPath.row])
            }
            
            else {
                cell.updateCellUI(pokemodel: pokeArray[indexPath.row])

            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pokemon: Pokemon!
        if searchModeIsOn == true {
            pokemon = filteredPokeArray[indexPath.row]
        }
        
        else {
            pokemon = pokeArray[indexPath.row]
        }

        
        performSegue(withIdentifier: "unwind", sender: pokemon.pokeID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwind" {
            if let destination  = segue.destination as? ViewController {
                if let pokeID = sender as? Int {
                    destination.pokeNumber = pokeID
                     let loc = CLLocation(latitude: destination.mapView.centerCoordinate.latitude, longitude: destination.mapView.centerCoordinate.longitude)
                    
                        destination.createSighting(forLocation: loc, WithPokemon: pokeID)
                    
                }
            }
        }
    }
    
    
}

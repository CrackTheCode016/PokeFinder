//
//  PokeAnnotation.swift
//  PokeFinder
//
//  Created by Santiago on 10/21/17.
//  Copyright © 2017 Santiago. All rights reserved.
//

import Foundation

let pokemon = [
    
    "bulbasaur",
    
    "ivysaur",
    
    "venusaur",
    
    "charmander",
    
    "charmeleon",
    
    "charizard",
    
    "squirtle",
    
    "wartortle",
    
    "blastoise",
    
    "caterpie",
    
    "metapod",
    
    "butterfree",
    
    "weedle",
    
    "kakuna",
    
    "beedrill",
    
    "pidgey",
    
    "pidgeotto",
    
    "pidgeot",
    
    "rattata",
    
    "raticate",
    
    "spearow",
    
    "fearow",
    
    "ekans",
    
    "arbok",
    
    "pikachu",
    
    "raichu",
    
    "sandshrew",
    
    "sandslash",
    
    "nidoran-f",
    
    "nidorina",
    
    "nidoqueen",
    
    "nidoran-m",
    
    "nidorino",
    
    "nidoking",
    
    "clefairy",
    
    "clefable",
    
    "vulpix",
    
    "ninetales",
    
    "jigglypuff",
    
    "wigglytuff",
    
    "zubat",
    
    "golbat",
    
    "oddish",
    
    "gloom",
    
    "vileplume",
    
    "paras",
    
    "parasect",
    
    "venonat",
    
    "venomoth",
    
    "diglett",
    
    "dugtrio",
    
    "meowth",
    
    "persian",
    
    "psyduck",
    
    "golduck",
    
    "mankey",
    
    "primeape",
    
    "growlithe",
    
    "arcanine",
    
    "poliwag",
    
    "poliwhirl",
    
    "poliwrath",
    
    "abra",
    
    "kadabra",
    
    "alakazam",
    
    "machop",
    
    "machoke",
    
    "machamp",
    
    "bellsprout",
    
    "weepinbell",
    
    "victreebel",
    
    "tentacool",
    
    "tentacruel",
    
    "geodude",
    
    "graveler",
    
    "golem",
    
    "ponyta",
    
    "rapidash",
    
    "slowpoke",
    
    "slowbro",
    
    "magnemite",
    
    "magneton",
    
    "farfetchd",
    
    "doduo",
    
    "dodrio",
    
    "seel",
    
    "dewgong",
    
    "grimer",
    
    "muk",
    
    "shellder",
    
    "cloyster",
    
    "gastly",
    
    "haunter",
    
    "gengar",
    
    "onix",
    
    "drowzee",
    
    "hypno",
    
    "krabby",
    
    "kingler",
    
    "voltorb",
    
    "electrode",
    
    "exeggcute",
    
    "exeggutor",
    
    "cubone",
    
    "marowak",
    
    "hitmonlee",
    
    "hitmonchan",
    
    "lickitung",
    
    "koffing",
    
    "weezing",
    
    "rhyhorn",
    
    "rhydon",
    
    "chansey",
    
    "tangela",
    
    "kangaskhan",
    
    "horsea",
    
    "seadra",
    
    "goldeen",
    
    "seaking",
    
    "staryu",
    
    "starmie",
    
    "mr-mime",
    
    "scyther",
    
    "jynx",
    
    "electabuzz",
    
    "magmar",
    
    "pinsir",
    
    "tauros",
    
    "magikarp",
    
    "gyarados",
    
    "lapras",
    
    "ditto",
    
    "eevee",
    
    "vaporeon",
    
    "jolteon",
    
    "flareon",
    
    "porygon",
    
    "omanyte",
    
    "omastar",
    
    "kabuto",
    
    "kabutops",
    
    "aerodactyl",
    
    "snorlax",
    
    "articuno",
    
    "zapdos",
    
    "moltres",
    
    "dratini",
    
    "dragonair",
    
    "dragonite",
    
    "mewtwo",
    
    "mew"]

var viewSelected = false

class PokeAnnotation: NSObject, MKAnnotation {
    
    
    var coordinate = CLLocationCoordinate2D()
    var pokeNumber: Int
    var pokeName: String
    var title: String?
    
    
    init(coordinate: CLLocationCoordinate2D, pokeNumber: Int) {
        self.coordinate = coordinate
        self.pokeNumber = pokeNumber
        self.pokeName = pokemon[pokeNumber - 1].capitalized
        self.title = self.pokeName
    }
}
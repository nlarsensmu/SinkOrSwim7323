//
//  ScryFallCard.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/5/21.
//

import UIKit


class ScryFallCard: NSObject {
    
    var cardName:String = ""
    var typeLine:String = ""
    var manaCost:String = ""
    var oracleText:String = "" // Refers to the text of the card could be empty
    var power:String = "" // Could be empty for non-creatures
    var toughness:String = "" // Could be empty for non-creatures
    
    init(dict:NSDictionary) {
        if let cardName = dict["name"] as? String {
            self.cardName = cardName
        }
        
        if let typeLine = dict["type_line"] as? String {
            self.typeLine = typeLine
        }
        
        if let manaCost = dict["mana_cost"] as? String {
            self.manaCost = manaCost
        }
        
        if let oracleText = dict["oracle_text"] as? String {
            self.oracleText = oracleText
        }
        
        if let power = dict["power"] as? String{
            self.power = power
        }
        
        if let toughness = dict["toughness"] as? String {
            self.toughness = toughness
        }
        
    }
}

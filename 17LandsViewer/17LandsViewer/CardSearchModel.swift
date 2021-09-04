//
//  CardSearchModel.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

import Foundation

class CardSearchModel: NSObject {
    
    
    weak private var metaDataModel:MagicMetadataModel? = MagicMetadataModel.sharedInstance
    
    private var colors = ["White", "Blue", "Red", "Green", "Black", "Colorless"]
    private var rarities = ["common", "uncommon", "rare", "mythic rare"]
    
    func getColors() -> [String] {
        return self.colors
    }
    
    func getRarities() -> [String] {
        return self.rarities
    }
    
    func getSets() -> [String] {
        
        var sets:[String] = []
        
        if let s = self.metaDataModel?.getSets() {
            sets = s
        }
        
        return sets
    }
}

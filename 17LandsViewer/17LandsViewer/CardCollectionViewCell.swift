//
//  CardCollectionViewCell.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/5/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: CardImageView!
    @IBOutlet weak var improvementLabel: UILabel!
    var card:Card?
    
}

//
//  CardViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/4/21.
//

import UIKit

class CardViewController: UIViewController {

    var card:Card?
    weak private var metaDataModel:MagicMetadataModel? = MagicMetadataModel.sharedInstance
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImageView: CardImageView!
    @IBOutlet weak var notInDecklabel: UILabel!
    @IBOutlet weak var openingHandLabel: UILabel!
    @IBOutlet weak var drawnOneOrLaterLabel: UILabel!
    @IBOutlet weak var everInHandLabel: UILabel!
    @IBOutlet weak var notDrawnLabel: UILabel!
    @IBOutlet weak var improvementLabel: UILabel!
    @IBOutlet var imageTapGesture: UITapGestureRecognizer!
    var img:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            if let c = self.card {
                self.cardNameLabel.text = c.name
                
                self.cardImageView.downloaded(from: c.url)
                
                self.notInDecklabel.text = String(format: "%.2lf%%", c.sideboardWinRate*100)
                self.openingHandLabel.text = String(format: "%.2lf%%", c.openingHandWinRate*100)
                self.drawnOneOrLaterLabel.text = String(format: "%.2lf%%", c.drawnWinRate*100)
                self.everInHandLabel.text = String(format: "%.2lf%%", c.everDrawnWinRate*100)
                self.notDrawnLabel.text = String(format: "%.2lf%%", c.neverDrawnWinRate*100)
                self.improvementLabel.text = String(format: "%.2lf%%", c.drawnImprovementWinRate*100)
            }
        }
        // Do any additional setup after loading the view.
        self.cardImageView.isUserInteractionEnabled = true
        self.cardImageView.addGestureRecognizer(self.imageTapGesture)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? FullCardViewController {
            vc.cardImage = self.cardImageView.image
        }
    }
    

}

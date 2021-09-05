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
    @IBOutlet weak var cardTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Go get Text Card data
        if let c = card {
            let cardData:ScryFallCard? = ScryFallModel.getCardDataFromScryFall(cardName: c.name)
            DispatchQueue.main.async {
                if let card = cardData {
                    var text =
                        """
                        \(card.manaCost)
                        \(card.cardName)
                        \(card.typeLine)
                        \(card.oracleText)
                        """
                    if card.power != "" && card.toughness != "" {
                        text.append("\n\(card.power)/\(card.toughness)")
                    }
                    self.cardTextView.text = text
                }
            }
        }
        
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
                
                self.cardTextView.isHidden = true
                self.cardTextView.isEditable = false
            }
        }
        // Do any additional setup after loading the view.
        self.cardImageView.isUserInteractionEnabled = true
        self.cardImageView.addGestureRecognizer(self.imageTapGesture)
    }
    
    // MARK: - Segmented Control
    @IBAction func updateFromSegmentedControl(_ sender: Any) {
        if let s = sender as? UISegmentedControl,
           let type = s.titleForSegment(at: s.selectedSegmentIndex) {
            
            if type == "Text" {
                DispatchQueue.main.async {
                    self.cardImageView.isHidden = true
                    self.cardTextView.isHidden = false
                }
            }
            else {
                DispatchQueue.main.async {
                    self.cardImageView.isHidden = false
                    self.cardTextView.isHidden = true
                }
            }
        }
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

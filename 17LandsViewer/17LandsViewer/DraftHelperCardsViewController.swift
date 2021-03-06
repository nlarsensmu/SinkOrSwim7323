//
//  DraftHelperCardsViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/5/21.
//

import UIKit

class DraftHelperCardsViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cardNameTextField: UITextField!
    var enterClicked:Bool = false
    var format:String = ""
    var set:String = ""
    var cardToAdd:String = ""
    var cards:[ScryFallCard] = []
    
    lazy private var metaDataModel:MagicMetadataModel? = {
        return MagicMetadataModel.sharedInstance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cardNameTextField.delegate = self
        self.enterClicked = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - UITextField Delegation
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.enterClicked = true
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didCancelKeyboard(_ sender: Any) {
        self.cardNameTextField.resignFirstResponder()
    }
    
    // MARK: - CollectionViewDelegate and DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
        let section = indexPath.section
        let item = indexPath.item
        print("\(row) \(section) \(item)")
        print("cards in cards")
        for card in self.cards{
            print(card.cardName)
        }
        var returnCell:UICollectionViewCell? = nil
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cardCollectionViewCell", for: indexPath) as? CardCollectionViewCell {
            cell.imageView.downloaded(from: self.cards[indexPath.row].imgSmall)
            
            cell.improvementLabel.text = cards[indexPath.row].improvement
            
            // Find the cards from the metaDataModel and pass it in.
            var card:Card?
            if let metaDataCards = metaDataModel?.getCardStatsForSet(expansion: set, format: format) {
                for c in metaDataCards {
                    if c.name == self.cards[indexPath.row].cardName {
                        card = c
                    }
                }
            }
            if let c = card {
                cell.card = c
            }
            returnCell = cell
        }
     
        if let cell = returnCell {
            return cell
        }
        else{
            fatalError("problem getting card cell")
        }
    }
    
    
    
    // MARK: - Navigation
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        self.enterClicked = false
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view
        
        if let vc = segue.destination as? CardResultsPopUpTableViewController {
            vc.name = self.cardNameTextField.text
            vc.format = self.format
            vc.set = self.set
            vc.delegate = self
            vc.popoverPresentationController?.delegate = self
        }
        
        if let vc = segue.destination as? CardViewController, let s = sender as? CardCollectionViewCell {
            vc.card = s.card
        }
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if self.enterClicked {
            return true
        }
        return false
    }
}

extension DraftHelperCardsViewController: PassDataDelegate {
    func passData(_ data: String) {
        let datas = data.components(separatedBy: "|")
        print("cardName \(datas[0]) IP \(datas[1])")

        if let card:ScryFallCard = ScryFallModel.getCardDataFromScryFall(cardName: datas[0]) {
            card.improvement = datas[1]
            DispatchQueue.main.async {
                print(card.imgSmall)
                self.cards.append(card)
            }
            
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

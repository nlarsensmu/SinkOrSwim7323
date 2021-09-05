//
//  CardSearchViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

import UIKit

class CardSearchViewController: UIViewController, UIPickerViewDelegate,  UIPickerViewDataSource, UITextFieldDelegate {

    // 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setColorRarityPicker.delegate = self
        setColorRarityPicker.dataSource = self
        cardNameField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var cardNameField: UITextField!
    @IBOutlet weak var setColorRarityPicker: UIPickerView!
    
    lazy var cardSearchModel:CardSearchModel = {
        return CardSearchModel.init() // look into whether or not to make this a "shared instance"
    }()
    
    // MARK: - UIPickerViewDelegate Functions:
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView:UIPickerView, numberOfRowsInComponent:Int)-> Int{
        switch numberOfRowsInComponent {
        case 0:
            return cardSearchModel.getSets().count + 1
        case 1:
            return cardSearchModel.getColors().count + 1
        case 2:
            return cardSearchModel.getRarities().count + 1
        case 3:
            return cardSearchModel.getFormats().count + 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            if row == 0 {
                return "Set"
            }
            return self.cardSearchModel.getSets()[row-1]
        case 1:
            if row == 0 {
                return "Color"
            }
            return self.cardSearchModel.getColors()[row-1]
        case 2:
            if row == 0 {
                return "Rarity"
            }
            return self.cardSearchModel.getRarities()[row-1]
        case 3:
            if row == 0 {
                return "Format"
            }
            return self.cardSearchModel.getFormats()[row-1]
        default:
            return ""
        }
    }
    
    
    @IBAction func tapGesture(_ sender: Any) {
        self.cardNameField.resignFirstResponder()
    }
    // MARK: - UITextField Delegation
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didCancelKeyboard(_ sender: Any) {
        self.cardNameField.resignFirstResponder()
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? CardResultsTableViewController {
            let rowSet = setColorRarityPicker.selectedRow(inComponent: 0)
            let rowColor = setColorRarityPicker.selectedRow(inComponent: 1)
            let rowRarity = setColorRarityPicker.selectedRow(inComponent: 2)
            let rowFormat = setColorRarityPicker.selectedRow(inComponent: 3)
            
            if cardNameField.text != "" {
                vc.name = cardNameField.text
            }
            if rowSet != 0 {
                vc.set = cardSearchModel.getSets()[rowSet - 1]
            }
            if rowColor != 0 {
                vc.color = cardSearchModel.getColors()[rowColor - 1]
            }
            if rowRarity != 0 {
                vc.rarity = cardSearchModel.getRarities()[rowRarity - 1]
            }
            if rowFormat != 0 {
                vc.format = cardSearchModel.getFormats()[rowFormat - 1]
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let rowSet = setColorRarityPicker.selectedRow(inComponent: 0)
        let rowFormat = setColorRarityPicker.selectedRow(inComponent: 3)
        if rowSet != 0 && rowFormat != 0{
           return true
        }
        else{
            return false
        }
    }
}

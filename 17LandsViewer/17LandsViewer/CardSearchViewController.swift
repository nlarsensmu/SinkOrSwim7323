//
//  CardSearchViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

import UIKit

class CardSearchViewController: UIViewController, UIPickerViewDelegate,  UIPickerViewDataSource{

    // 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setColorRarityPicker.delegate = self
        setColorRarityPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var setColorRarityPicker: UIPickerView!
    lazy var cardSearchModel:CardSearchModel = {
        return CardSearchModel.init() // look into whether or not to make this a "shared instance"
    }()
    
    // UIPickerViewDelegate Functions:
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView:UIPickerView, numberOfRowsInComponent:Int)-> Int{
        switch numberOfRowsInComponent {
        case 0:
            return cardSearchModel.getSets().count + 1
        case 1:
            return cardSearchModel.getColors().count + 1

        case 2:
            return cardSearchModel.getRarities().count + 1 
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
        default:
            return ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

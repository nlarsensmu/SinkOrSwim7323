//
//  DraftViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/5/21.
//

import UIKit

class DraftViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    weak private var metaDataModel:MagicMetadataModel? = MagicMetadataModel.sharedInstance
    
    lazy var cardSearchModel:CardSearchModel = {
        return CardSearchModel.init() // look into whether or not to make this a "shared instance"
    }()
    
    
    @IBOutlet weak var formatSetPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.formatSetPicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // MARK: DataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            if let c = metaDataModel?.getSets().count {
                return c
            }
            return 0
        }
        else {
            if let c = metaDataModel?.getFormats().count {
                return c
            }
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            if row == 0 {
                return "Set"
            }
            else {
                if let set = metaDataModel?.getSets()[row-1] {
                    return set
                }
                return ""
            }
        }
        else {
            if row == 0 {
                return "Format"
            }
            else {
                if let format = metaDataModel?.getFormats()[row-1] {
                    return format
                }
                return ""
            }
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let rowSet = self.formatSetPicker.selectedRow(inComponent: 0)
        let rowFormat = self.formatSetPicker.selectedRow(inComponent: 1)
        
        if let vc = segue.destination as? DraftHelperCardsViewController, let model = self.metaDataModel {
            vc.format = model.getFormats()[rowFormat - 1]
            vc.set = model.getSets()[rowSet - 1]
        }
    }
    

}

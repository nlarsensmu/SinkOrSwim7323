//
//  DraftHelperViewController.swift
//  17LandsViewer
//
//  Created by Steven on 9/4/21.
//

import UIKit

class DraftHelperViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
    var metaDataModel: MagicMetadataModel? =  MagicMetadataModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPicker.delegate = self
        setPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView:UIPickerView, numberOfRowsInComponent:Int)-> Int{
        if(numberOfRowsInComponent == 0){
            if let row:Int = self.metaDataModel?.getSets().count{
                return row + 1
            }
            return 0
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            if row == 0 {
                return "Set"
            }
            return self.metaDataModel?.getSets()[row-1]
        }
        return ""
    }

    
     @IBOutlet weak var setPicker: UIPickerView!
     // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rowSet = setPicker.selectedRow(inComponent: 0)
        let setString = metaDataModel?.getSets()[rowSet - 1]
        if let vc = segue.destination as? DraftHelperCollectionViewController,
           let set = setString {
            vc.set = set
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let rowSet = setPicker.selectedRow(inComponent: 0)
        if rowSet != 0  {
           return true
        }
        else{
            return false
        }
        
    }

}

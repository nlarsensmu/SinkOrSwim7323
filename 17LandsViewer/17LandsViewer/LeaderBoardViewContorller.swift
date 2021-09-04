//
//  LeaderBoardViewContorller.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

import UIKit

class LeaderBoardViewContorller: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    

    weak private var metaDataModel:MagicMetadataModel? = MagicMetadataModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView:UIPickerView, numberOfRowsInComponent:Int)-> Int{
        if(numberOfRowsInComponent == 0){
            if let row:Int = self.metaDataModel?.getSets().count{
                return row + 1
            }
            return 0
        }
        else if (numberOfRowsInComponent == 1){
            if let row:Int = self.metaDataModel?.getRanking().count{
                return row + 1
            }
            return 0
        }
        else{
            if let row:Int = self.metaDataModel?.getFormats().count{
                return row + 1
            }
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            if row == 0 {
                return "Set"
            }
            return self.metaDataModel?.getSets()[row-1]
        }
        else if (component == 1){
            if row == 0 {
                return "Rank"
            }
            return self.metaDataModel?.getRanking()[row-1]
        }
        else{
            if row == 0 {
                return "Format"
            }
            return self.metaDataModel?.getFormats()[row-1]
        }
    }
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var searchButton: UIButton!

    var leaderBoard:PlayerLeaderBoard?
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        

        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let vc = segue.destination as? LeaderBoardTableViewController{
            let rowSet = picker.selectedRow(inComponent: 0)
            let rowRank = picker.selectedRow(inComponent: 1)
            let rowFormat = picker.selectedRow(inComponent: 2)
            if rowSet != 0 && rowRank != 0 && rowFormat != 0 {
                vc.set = metaDataModel?.getSets()[rowSet - 1]
                vc.ranking = metaDataModel?.getRanking()[rowRank - 1]
                vc.format = metaDataModel?.getFormats()[rowFormat - 1]
            }
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let rowSet = picker.selectedRow(inComponent: 0)
        let rowRank = picker.selectedRow(inComponent: 1)
        let rowFormat = picker.selectedRow(inComponent: 2)
        if rowSet != 0 && rowRank != 0 && rowFormat != 0 {
           return true
        }
        else{
            return false
        }
        
    }
    

}

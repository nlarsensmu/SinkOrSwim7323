//
//  CardResultsTableViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/4/21.
//

import UIKit

class CardResultsTableViewController: UITableViewController {

    
    var name:String?
    var set:String?
    var color:String?
    var rarity:String?
    var format:String?
    
    var results:[Card] = []
    
    
    lazy private var metaDataModel:MagicMetadataModel? = {
        return MagicMetadataModel.sharedInstance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var colors:[String] = []
        if let c = self.color {
            colors = [c]
        }        
        
        if let s = self.set, let f = self.format, let results = metaDataModel?.getCardStatsForSet(expansion: s, format: f, colorsFilter: colors, rarity: self.rarity, name: self.name) {
            self.results = results
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
     }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellID = ""
        
        if results[indexPath.row].color == "W" {
            cellID = "cardResultCellWhite"
        } else if results[indexPath.row].color == "U" { // U represents shorthand for Blue in MTG
            cellID = "cardResultCellBlue"
        } else if results[indexPath.row].color == "R" {
            cellID = "cardResultCellRed"
        } else if results[indexPath.row].color == "G" {
            cellID = "cardResultCellGreen"
        } else if results[indexPath.row].color == "B" {
            cellID = "cardResultCellBlack"
        } else if results[indexPath.row].color.count > 1 {
            cellID = "cardResultCellGold"
        } else if results[indexPath.row].color == "" {
            cellID = "cardResultCellColorless"
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = self.results[indexPath.row].name
//        cell.textLabel?.textColor = colorText
        cell.detailTextLabel?.text = results[indexPath.row].rarity

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destination as? CardViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = self.tableView.indexPath(for:cell){
            vc.card = results[indexPath.row]
        }
        
        if let vc = segue.destination as?  DraftViewController {
            print(vc)
        }
    }
    

}

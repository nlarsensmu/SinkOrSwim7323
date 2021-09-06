//
//  LeaderBoardTableViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

import UIKit

class LeaderBoardTableViewController: UITableViewController {
    
    weak private var metaDataModel:MagicMetadataModel? = MagicMetadataModel.sharedInstance

    var set:String?
    var format:String?
    var ranking:String?
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let s = self.set, let f = self.format, let r = self.ranking {
            
        }
        let timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true, block: { timer in
            if  let s = self.set, let f = self.format, let r = self.ranking,
                let tp = self.metaDataModel?.getLeaderBoards(expansion: s, format: f, ranking: r, lazy: false) {
                    print("there are \(tp.count) players in the \(r) leaderboard")
                    //reload the table
                }
        })
        let loop: RunLoop = RunLoop()
        loop.add(timer, forMode: RunLoop.Mode.common)
        
        
        self.timer = timer
        
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
        if let model = self.metaDataModel,
           let s = self.set, let f = self.format, let r = self.ranking,
           let players =  model.getLeaderBoards(expansion: s, format: f , ranking: r ){
            return players.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        let index = indexPath.row
        var topPlayers: [Player]  = []
        DispatchQueue.main.async {
            if let model = self.metaDataModel,
               let s = self.set, let f = self.format, let r = self.ranking,
               let players =  model.getLeaderBoards(expansion: s, format: f , ranking: r ){
                topPlayers = players
            }
            
            // Configure the cell...
            cell.textLabel?.text = "\(index + 1). \(topPlayers[indexPath.row].screenName)"
            
            if let r = self.ranking {
                switch r {
                case "rank":
                    cell.detailTextLabel?.text = topPlayers[indexPath.row].rank
                case "win rate":
                    cell.detailTextLabel?.text = String(format: "%.2lf%%", topPlayers[indexPath.row].winRate * 100)
                case "trophies":
                    cell.detailTextLabel?.text = String(format: "%d", topPlayers[indexPath.row].trophies)
                case "wins":
                    cell.detailTextLabel?.text = String(format: "%d", topPlayers[indexPath.row].wins)
                case "trophy rate":
                    cell.detailTextLabel?.text = String(format: "%.2lf%%", topPlayers[indexPath.row].trophyRate * 100)
                default:
                    cell.detailTextLabel?.text = "No data"
                }
                
            }
        }
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
        var test = sender
        if let cell = sender as? UITableViewCell{
            if let indexPath = self.tableView.indexPath(for: cell) as? IndexPath,
               let index = indexPath.row as? Int,
               let playerController = segue.destination as? PlayerViewController,
               let s = self.set,
               let f = self.format,
               let r = self.ranking,
               let leaderboard = self.metaDataModel?.getLeaderBoards(expansion: s, format: f, ranking: r) {
                playerController.player = leaderboard[index]
                playerController.rank = index + 1
                if let model = self.metaDataModel,
                   let s = self.set, let f = self.format, let r = self.ranking,
                   let players =  model.getLeaderBoards(expansion: s, format: f , ranking: r ){
                    playerController.maxValue = players.count
                }
                playerController.minValue = 1
            }
        }
    }
    

}

//
//  MagicMetadataModel.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

import UIKit

class MagicMetadataModel: NSObject {
    
    public static var sharedInstance:MagicMetadataModel? = {
        var sharedInstance:MagicMetadataModel? = nil
        
        if(sharedInstance == nil) {
            sharedInstance = MagicMetadataModel()
        }
        
        return sharedInstance
    }()
    private var sets =  ["STX","AFR","KHM","ZNR","KLR","M21","AKR","IKO","THB","ELD","M20","WAR","RNA","GRN","M19","DOM","RIX","XLN","MH2","MH1","2XM","TSR","Ravnica","CORE","Cube"];
    private var formats = ["Sealed","PremierDraft","QuickDraft","CompDraft"]
    private var rankings = ["wins","actual rank","win rate","trophies", "trophy rate"]
    
    func getLeaderBoards(expansion: String, format: String, ranking: String) -> [Player]? {
        let url : String = "https://www.17lands.com/data/leaderboard?expansion=\(expansion)&format=\(format)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        var dataRecieved: Data?
        let sem = DispatchSemaphore.init(value: 0)
        
        var leaderBoardData: NSDictionary? = nil
        let task = session.dataTask(with: request) { data, response, error in
            defer { sem.signal() }
            
            if let error = error {
                print("error getting leaderboard \(error)")
                return
            }
            dataRecieved = data
        }
        task.resume()
        sem.wait()
        do{
            leaderBoardData = try JSONSerialization.jsonObject(with: dataRecieved!) as? NSDictionary
        }
        catch{
            print("error getting leaderboard \(error)")
        }
        var players:[Player]
        let leaderBoard = PlayerLeaderBoard(leaderBoard: leaderBoardData!)
        
        switch ranking {
        case "actual rank":
            players = leaderBoard.rank
        case "wins":
            players = leaderBoard.wins
        case "win rate":
            players = leaderBoard.winRate
        case "trophies":
            players = leaderBoard.trophies
        case "trophy reate":
            players = leaderBoard.trophyRate
        default:
            players = []
        }
        return players
    }
    func getSets() -> [String]{
        return self.sets
    }
    func getRanking() -> [String]{
        return self.rankings
    }
    func getFormats() -> [String]{
        return self.formats
    }

}

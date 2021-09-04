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
    private var sets =  ["STX","AFR"];
    private var formats = ["Sealed","PrimierDraft"]
    private var rankings = ["Rank","Wins"]
    
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
        case "rank":
            players = leaderBoard.rank
            for player in players {
                print("\(player.screenName) \(player.rank)")
            }
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

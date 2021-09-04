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
    func getCardStatsForSet(expansion: String, format: String) -> [Card] {
            let url : String = "https://www.17lands.com/card_ratings/data?expansion=\(expansion)&format=\(format)&start_date=2021-04-30&end_date=2021-08-31"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let session = URLSession.shared
            
            var dataRecieved: Data?
            let sem = DispatchSemaphore.init(value: 0)
            
            var cardsData: NSArray = []
        var cards: [Card] = []
            let task = session.dataTask(with: request) { data, response, error in
                defer { sem.signal() }
                
                if let error = error {
                    print("error getting cards \(error)")
                    return
                }
                dataRecieved = data
            }
            task.resume()
            sem.wait()
            do{
                cardsData = try JSONSerialization.jsonObject(with: dataRecieved!) as! NSArray
                for card in cardsData{
                    if let c = card as? NSDictionary{
                        cards.append(Card(card:c))
                    }
                }
            }
            catch{
                print("error getting colors \(error)")
            }
            return cards
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

    
    //private helper function
    private func filterCards(cards:[Card]) -> [Card]{
        var returnCards: [Card] = []
        
        
        return returnCards
    }
}
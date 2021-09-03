//
//  ViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 8/31/21.
//

import UIKit
class ViewController: UIViewController {
    // Number of columns of data
    var colors: NSArray = []{
        didSet{
            DispatchQueue.main.async {
                print("there is \(self.colors.count) colors")
            }
            
        }
    }
    var cards: NSArray = [] {
        didSet{
            DispatchQueue.main.async {
                print("there is \(self.cards.count) cards")
            }
        }
    }
    var leaderBoard: PlayerLeaderBoard = PlayerLeaderBoard() {
        didSet{
            DispatchQueue.main.async {
                print("there is \(self.leaderBoard.rank.count) players in the rank leaderboard")
                print("there is \(self.leaderBoard.trophies.count) players in the trophies leaderboard")
                print("there is \(self.leaderBoard.trophyRate.count) players in the trophy rate leaderboard")
                print("there is \(self.leaderBoard.winRate.count) players in the win rate leaderboard")
                print("there is \(self.leaderBoard.wins.count) players in the wins leaderboard")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Hello World")
        
        if let _colors = getColors() {
            self.colors = _colors
        }
        
        if let _cards = getCardStatsForSet(expansion: "AFR", format: "PremierDraft"){
            self.cards = _cards
        }
        
        if let _leaderBoard = getLeaderBoards(expansion: "stx", format: "PremierDraft"){
            self.leaderBoard = _leaderBoard
        }
    }
    //https://stackoverflow.com/questions/38952420/swift-wait-until-datataskwithrequest-has-finished-to-call-the-return
    //Semephore logic pulled from this forum.
    func getColors() -> NSArray? {
        let url : String = "https://www.17lands.com/data/colors"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        var dataRecieved: Data?
        let sem = DispatchSemaphore.init(value: 0)
        
        var colors: NSArray = []
        
        let task = session.dataTask(with: request) { data, response, error in
            defer { sem.signal() }
            
            if let error = error {
                print("error getting colors \(error)")
                return
            }
            dataRecieved = data
        }
        task.resume()
        sem.wait()
        do{
            colors = try JSONSerialization.jsonObject(with: dataRecieved!) as! NSArray
        }
        catch{
            print("error getting colors \(error)")
        }
        return colors
    }
    func getCardStatsForSet(expansion: String, format: String) -> NSArray? {
        let url : String = "https://www.17lands.com/card_ratings/data?expansion=\(expansion)&format=\(format)&start_date=2021-04-30&end_date=2021-08-31"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        var dataRecieved: Data?
        let sem = DispatchSemaphore.init(value: 0)
        
        var cards: NSArray = []
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
            cards = try JSONSerialization.jsonObject(with: dataRecieved!) as! NSArray
        }
        catch{
            print("error getting colors \(error)")
        }
        return cards
    }
    func getLeaderBoards(expansion: String, format: String) -> PlayerLeaderBoard? {
        let url : String = "https://www.17lands.com/data/leaderboard?expansion=\(expansion)&format=\(format)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        var dataRecieved: Data?
        let sem = DispatchSemaphore.init(value: 0)
        
        var leaderBoard: NSDictionary? = nil
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
            leaderBoard = try JSONSerialization.jsonObject(with: dataRecieved!) as? NSDictionary
        }
        catch{
            print("error getting colors \(error)")
        }
        return PlayerLeaderBoard(leaderBoard: leaderBoard!)
    }
    
}




//
//  MagicMetadataModel.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

import UIKit

class MagicMetadataModel: NSObject {
    
    private static var _sharedInstance:MagicMetadataModel? = {
        var sharedInstance:MagicMetadataModel? = nil
        
        if(_sharedInstance == nil) {
            _sharedInstance = MagicMetadataModel()
        }
        
        return sharedInstance
    }()
    
    
    
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
            print("error getting leaderboard \(error)")
        }
        return PlayerLeaderBoard(leaderBoard: leaderBoard!)
    }

}

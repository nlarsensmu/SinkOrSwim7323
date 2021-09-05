//
//  File.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/5/21.
//

import Foundation
class ScryFallModel {
    static func getCardDataFromScryFall(cardName: String) -> ScryFallCard? {
        
        let cardNameUrl = cardName.replacingOccurrences(of: "+", with: "%2B").replacingOccurrences(of: " ", with: "%20")
        let url : String = "https://api.scryfall.com/cards/named?exact=\(cardNameUrl)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        var dataRecieved: Data?
        let sem = DispatchSemaphore.init(value: 0)
        
        var cardData: NSDictionary
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
            cardData = try JSONSerialization.jsonObject(with: dataRecieved!) as! NSDictionary
            return ScryFallCard.init(dict: cardData)
        }
        catch{
            print("error getting colors \(error)")
            return nil
        }
    }
}

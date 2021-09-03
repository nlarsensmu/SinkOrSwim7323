//
//  Player.swift
//  17LandsViewer
//
//  Created by Steven on 9/3/21.
//

import Foundation
class Player{
    init(player: NSDictionary){
        if let screenName = player["screen_name"] as? String,
           let wins = player["wins"] as? Int64,
           let winRate = player["winRate"] as? Double,
           let trophies = player["trophies"] as? Int64,
           let trophyRate = player["trophyRate"] as? Double,
           let rank = player["rank"] as? String{
            self.screenName = screenName
            self.rank = rank
            self.wins = wins
            self.winRate = winRate
            self.trophies = trophies
            self.trophyRate = trophyRate
        }
    }
    var screenName:String = ""
    var wins: Int64 = 0
    var winRate: Double = 0.0
    var trophies: Int64 = 0
    var trophyRate: Double = 0.0
    var rank:String = ""
}
class PlayerLeaderBoard{
    init(){
        self.wins = []
        self.winRate = []
        self.trophies = []
        self.trophyRate = []
        self.rank = []
    }
    init(leaderBoard: NSDictionary){
        self.wins = []
        self.rank = []
        self.trophies = []
        self.trophyRate = []
        self.winRate = []
        
        if let _wins = leaderBoard["wins"] as?  NSArray{
            for _win in _wins {
                if let w = _win as? NSDictionary{
                    self.wins.append(Player(player: w))
                }
            }
        }
        if let _ranks = leaderBoard["wins"] as?  NSArray{
            for _rank in _ranks {
                if let r = _rank as? NSDictionary{
                    self.rank.append(Player(player: r))
                }
            }
        }
        if let _trophies = leaderBoard["wins"] as?  NSArray{
            for _trophie in _trophies {
                if let t = _trophie as? NSDictionary{
                    self.trophies.append(Player(player: t))
                }
            }
        }
        if let _trophyRates = leaderBoard["wins"] as?  NSArray{
            for _trophyRate in _trophyRates {
                if let t = _trophyRate as? NSDictionary{
                    self.trophyRate.append(Player(player: t))
                }
            }
        }
        if let _winRates = leaderBoard["wins"] as?  NSArray{
            for _winRate in _winRates {
                if let w = _winRate as? NSDictionary{
                    self.winRate.append(Player(player: w))
                }
            }
        }
 
    }
    var wins: [Player] = []
    var winRate: [Player] = []
    var trophies: [Player] = []
    var trophyRate: [Player] = []
    var rank: [Player] = []

}


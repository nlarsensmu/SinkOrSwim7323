//
//  Card.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

import Foundation
class Card{
    init(card: NSDictionary){
        if let seenCount = card["seen_count"] as? Int64,
           let avgSeen = card["avg_seen"] as? Double,
           let pickCount = card["pick_count"] as? Int64,
           let avgPick = card["avg_pick"] as? Double,
           let gameCount = card["game_count"] as? Int64,
           let winRate = card["win_rate"] as? Double,
           let sideboardGameCount = card["sideboard_game_count"] as? Int64,
           let sideboardWinRate = card["sideboard_win_rate"] as? Double,
           let openingHandGameCount = card["opening_hand_game_count"] as? Int64,
           let openingHandWinRate = card["opening_hand_win_rate"] as? Double,
           let drawnGameCount = card["drawn_game_count"] as? Int64,
           let drawnWinRate = card["drawn_win_rate"] as? Double,
           let everDrawnGameCount = card["ever_drawn_game_count"] as? Int64,
           let everDrawnWinRate = card["ever_drawn_win_rate"] as? Double,
           let neverDrawnGameCount = card["never_drawn_game_count"] as? Int64,
           let neverDrawnWinRate = card["never_drawn_win_rate"] as? Double,
           let drawnImprovementWinRate = card["drawn_improvement_win_rate"] as? Double,
           let name = card["name"] as? String,
           let color = card["color"] as? String,
           let rarity = card["rarity"] as? String,
           let url = card["url"] as? String,
           let urlBack = card["url_back"] as? String
           {
            self.seenCount = seenCount
            self.avgSeen = avgSeen
            self.pickCount = pickCount
            self.avgPick = avgPick
            self.gameCount = gameCount
            self.winRate = winRate
            self.sideboardGameCount = sideboardGameCount
            self.sideboardWinRate = sideboardWinRate
            self.openingHandGameCount = openingHandGameCount
            self.openingHandWinRate = openingHandWinRate
            self.drawnGameCount = drawnGameCount
            self.drawnWinRate = drawnWinRate
            self.everDrawnGameCount = everDrawnGameCount
            self.everDrawnWinRate = everDrawnWinRate
            self.neverDrawnGameCount = neverDrawnGameCount
            self.neverDrawnWinRate = neverDrawnWinRate
            self.drawnImprovementWinRate = drawnImprovementWinRate
            self.name = name.lowercased()
            self.color = color
            self.rarity = rarity
            self.url = url
            self.urlBack = urlBack
           }
    }
    var seenCount: Int64 = 0
    var avgSeen: Double = 0.0;
    var pickCount: Int64 = 0;
    var avgPick: Double = 0.0;
    var gameCount: Int64 = 0;
    var winRate: Double = 0.0;
    var sideboardGameCount: Int64 = 0;
    var sideboardWinRate: Double = 0.0;
    var openingHandGameCount: Int64 = 0;
    var openingHandWinRate: Double = 0.0;
    var drawnGameCount: Int64 = 0;
    var drawnWinRate: Double = 0.0;
    var everDrawnGameCount: Int64 = 0;
    var everDrawnWinRate: Double = 0.0;
    var neverDrawnGameCount: Int64 = 0;
    var neverDrawnWinRate: Double = 0.0;
    var drawnImprovementWinRate: Double = 0.0;
    var name = "";
    var color = "";
    var rarity = "";
    var url = "";
    var urlBack = "";
}

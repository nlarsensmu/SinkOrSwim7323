//
//  PlayerViewController.swift
//  17LandsViewer
//
//  Created by Steven on 9/4/21.
//

import UIKit

class PlayerViewController: UIViewController {
    var player:Player?
    var rank:Int = 0
    weak private var metaDataModel:MagicMetadataModel? = MagicMetadataModel.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.resetValues()
        }
    }
    private func resetValues(){
        if let name = player?.screenName {
            self.playerNameText.text = name
        }
        if let wins = player?.wins {
            self.winsText.text = String(wins)
        }
        if let winRate = player?.winRate {
            self.winRate.text = String(winRate)
        }
        if let trophies = player?.trophies {
            self.tophiesText.text = String(trophies)
        }
        if let trophiesRate = player?.trophyRate {
            self.trophiesRate.text = String(trophiesRate)
        }
        rankLabel.text = String(rank)
        stepper.value = Double(rank)
        stepper.minimumValue = 0.0
        stepper.maximumValue = 500
        stepper.stepValue = 1.0
    }
    @IBAction func stepAction(_ sender: Any) {
        self.rank = Int(stepper.value)
        DispatchQueue.main.async {
            self.resetValues()
            
        }
    }
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var winRate: UILabel!
    @IBOutlet weak var trophiesRate: UILabel!
    @IBOutlet weak var tophiesText: UILabel!
    @IBOutlet weak var winsText: UILabel!
    @IBOutlet weak var playerNameText: UILabel!
}

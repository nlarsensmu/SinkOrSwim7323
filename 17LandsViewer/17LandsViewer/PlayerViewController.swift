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
    var minValue: Int = 0
    var maxValue: Int = 500
    lazy private var metaDataModel:MagicMetadataModel? = {
        return MagicMetadataModel.sharedInstance
    }()
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
            self.winsText.text = "\(wins) wins"
        }
        if let winRate = player?.winRate {
            self.winRate.text = String(format: "%.2lf%%", winRate * 100)
        }
        if let trophies = player?.trophies {
            self.tophiesText.text = "\(trophies) trophies"
        }
        if let trophiesRate = player?.trophyRate {
            self.trophyRate.text = String(format: "%.2lf%%", trophiesRate * 100)
        }
        rankLabel.text = String(rank)
        stepper.value = Double(rank)
        stepper.stepValue = 1.0
    }
    @IBAction func stepAction(_ sender: UIStepper) {
        self.rank = Int(sender.value)
        self.rankSlider.setValue(Float(sender.value), animated: true)
        DispatchQueue.main.async {
            self.player = self.metaDataModel?.getPlayer(index: self.rank - 1)
            self.resetValues()
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        DispatchQueue.main.async {
            sender.setValue(Float(Int(sender.value)), animated: true)
            self.stepper.value = Double(Int(sender.value))
            self.rank = Int(sender.value)
            self.player = self.metaDataModel?.getPlayer(index: self.rank - 1)
            self.resetValues()
        }
    }
    @IBOutlet weak var rankSlider: UISlider!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tophiesText: UILabel!
    @IBOutlet weak var winsText: UILabel!
    @IBOutlet weak var playerNameText: UILabel!
    @IBOutlet weak var winRate: UILabel!
    @IBOutlet weak var trophyRate: UILabel!
}

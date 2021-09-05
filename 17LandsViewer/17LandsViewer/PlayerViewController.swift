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
            self.winsText.text = "\(wins) wins"
        }
        if let winRate = player?.winRate {
            self.winRate.text = "\(winRate) %"
        }
        if let trophies = player?.trophies {
            self.tophiesText.text = "\(trophies) trophies"
        }
        if let trophiesRate = player?.trophyRate {
            self.trophyRate.text = "\(trophiesRate) %"
        }
        rankLabel.text = String(rank)
        stepper.value = Double(rank)
        stepper.minimumValue = 1.0
        stepper.maximumValue = 500
        stepper.stepValue = 1.0
        rankSlider.maximumValue = 500
        rankSlider.minimumValue = 1
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
    var i = UIImage()
    @IBOutlet weak var rankSlider: UISlider!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var tophiesText: UILabel!
    @IBOutlet weak var winsText: UILabel!
    @IBOutlet weak var playerNameText: UILabel!
    @IBOutlet weak var winRate: UILabel!
    @IBOutlet weak var trophyRate: UILabel!
}

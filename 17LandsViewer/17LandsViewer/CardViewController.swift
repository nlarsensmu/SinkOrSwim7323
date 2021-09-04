//
//  CardViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/4/21.
//

import UIKit

class CardViewController: UIViewController {

    var cardName:String?
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.cardNameLabel.text = self.cardName
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

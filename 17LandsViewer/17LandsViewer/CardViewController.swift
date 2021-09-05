//
//  CardViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/4/21.
//

import UIKit

class CardViewController: UIViewController {

    var card:Card?
    weak private var metaDataModel:MagicMetadataModel? = MagicMetadataModel.sharedInstance
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var notInDecklabel: UILabel!
    @IBOutlet weak var openingHandLabel: UILabel!
    @IBOutlet weak var drawnOneOrLaterLabel: UILabel!
    @IBOutlet weak var everInHandLabel: UILabel!
    @IBOutlet weak var notDrawnLabel: UILabel!
    @IBOutlet weak var improvementLabel: UILabel!
    var img:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        DispatchQueue.main.async {
            if let c = self.card {
                self.cardImageView.downloaded(from: c.url)
                
                self.notInDecklabel.text = String(format: "%.2lf%%", c.sideboardWinRate*100)
                self.openingHandLabel.text = String(format: "%.2lf%%", c.openingHandWinRate*100)
                self.drawnOneOrLaterLabel.text = String(format: "%.2lf%%", c.drawnWinRate*100)
                self.everInHandLabel.text = String(format: "%.2lf%%", c.everDrawnWinRate*100)
                self.notDrawnLabel.text = String(format: "%.2lf%%", c.neverDrawnWinRate*100)
                self.improvementLabel.text = String(format: "%.2lf%%", c.drawnImprovementWinRate*100)
            }
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

extension UIImageView {
    func downloaded(from url:URL, contentMode mode:ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}

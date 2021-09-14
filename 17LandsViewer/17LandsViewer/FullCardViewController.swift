//
//  FullCardViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/4/21.
//

import UIKit

class FullCardViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    lazy private var metaDataModel:MagicMetadataModel? = {
        return MagicMetadataModel.sharedInstance
    }()
    
    var card:Card?
    var cardImage:UIImage?
    
    lazy private var imageView: UIImageView? = {
        return UIImageView.init(image: self.cardImage)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let size = self.imageView?.image?.size {
            self.scrollView.addSubview(self.imageView!)
            self.scrollView.contentSize = size
            self.scrollView.minimumZoomScale = 0.8
            self.scrollView.maximumZoomScale = 100 // This is comically large, I set it to this to satisfy assignment.
            self.scrollView.delegate = self
        }
        
        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
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

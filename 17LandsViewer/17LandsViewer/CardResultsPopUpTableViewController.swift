//
//  CardResultsPopUpTableViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/5/21.
//

import UIKit


class CardResultsPopUpTableViewController: CardResultsTableViewController, UIPopoverPresentationControllerDelegate {

    
    var delegate: PassDataDelegate?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var data:String = ""
        if let name = self.tableView.cellForRow(at: indexPath)?.textLabel?.text {
            data = name
        }
        delegate?.passData(data)
        self.dismiss(animated: true, completion: nil)
    }
}

protocol PassDataDelegate {
    func passData(_ data: String)
}

//
//  FirstScreenTableViewController.swift
//  17LandsViewer
//
//  Created by Nicholas Larsen on 9/3/21.
//

import UIKit

class FirstScreenTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    lazy var rootViewModel:RootViewModel = {
        return RootViewModel.sharedinstance()
    }()
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return rootViewModel.numberOfScreens()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: rootViewModel.getScreenIdent(from: indexPath.section), for: indexPath)
        cell.textLabel!.text = self.rootViewModel.getNameFrom(indexPath.section)
        return cell
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

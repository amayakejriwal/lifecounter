//
//  HistoryViewController.swift
//  LifeCounter
//
//  Created by Amaya Kejriwal on 4/28/22.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var historyLabel: UILabel!
    var historyToDisplay : String = ""
    
    @objc func displayHistory() {
        historyLabel.text = historyToDisplay
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayHistory()
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

//
//  ViewController.swift
//  LifeCounter
//
//  Created by Amaya Kejriwal on 4/19/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labP1name: UILabel!
    @IBOutlet weak var labP1count: UILabel!
    @IBOutlet weak var labP2name: UILabel!
    @IBOutlet weak var labP2count: UILabel!
    var P1lives = 20
    var P2lives = 20
    
    @IBAction func bP1minus5(_ sender: Any) {
        adjLives("p1", -5)
    }
    
    @IBAction func bP1minus1(_ sender: Any) {
        adjLives("p1", -1)
    }
    
    @IBAction func bP1plus1(_ sender: Any) {
        adjLives("p1", 1)
    }
    
    @IBAction func bP1plus5(_ sender: Any) {
        adjLives("p1", 5)
    }
    
    @IBAction func bP2minus5(_ sender: Any) {
        adjLives("p2", -5)
    }
    
    @IBAction func bP2minus1(_ sender: Any) {
        adjLives("p2", -1)
    }
    
    @IBAction func bP2plus1(_ sender: Any) {
        adjLives("p2", 1)
    }
    
    @IBAction func bP2plus5(_ sender: Any) {
        adjLives("p2", 5)
    }
    
    func adjLives(_ player: String, _ change : Int) {
        if player == "p1" {
            P1lives += change
        } else if player == "p2" {
            P2lives += change
        }
        changeCount()
        
        // show alert if someone won or lost!
        if P1lives <= 0 {
            showLoserAlert("1")
        } else if P2lives <= 0 {
            showLoserAlert("2")
        }
    }
    
    func showLoserAlert(_ loser : String) {
        let alert = UIAlertController(title: "GAME OVER", message: "Player \(loser) LOSES", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reset Counter", style: .default))
        self.present(alert, animated: true)
        
        // reset the game
        P1lives = 20
        P2lives = 20
        changeCount()
    }
    
    func changeCount() {
        labP1count.text = String(P1lives)
        labP2count.text = String(P2lives)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeCount()
    }
}


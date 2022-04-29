//
//  ViewController.swift
//  LifeCounter
//
//  Created by Amaya Kejriwal on 4/19/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var buttonAddPlayerReference: UIButton!
    @IBOutlet weak var buttonRemovePlayerReference: UIButton!
    @IBOutlet weak var textFieldLifeChunk: UITextField!
    var currentNumPlayers = 0
    var labels : [UILabel] = []
    var gameStarted : Bool = false
    var history : String = ""
    var lifeChunk = 5
    
    @IBAction func textFieldValueChanged(_ sender: Any) {
        lifeChunk = Int(textFieldLifeChunk.text!) ?? 0
        print("life chunk: \(String(describing: lifeChunk))")
    }
    @IBAction func textFieldEditingEnd(_ sender: Any) {
        lifeChunk = Int(textFieldLifeChunk.text!) ?? 0
        print("try 2 life chunk: \(String(describing: lifeChunk))")
    }
    
    @objc func setupToolbar(){
        //Create a toolbar
         let bar = UIToolbar()
         let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
         let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
         bar.items = [flexSpace, flexSpace, doneBtn]
         bar.sizeToFit()
        textFieldLifeChunk.inputAccessoryView = bar
     }
    
     @objc func dismissMyKeyboard(){
         view.endEditing(true)
         lifeChunk = Int(textFieldLifeChunk.text!) ?? 0
         reset(currentNumPlayers)
     }
    
    @objc func addPlayer() {
        let playerNum = currentNumPlayers + 1
        currentNumPlayers += 1
        checkButtons()
            
        // create the player name label
        let playerName = UILabel()
        playerName.text = "PLAYER \(playerNum)"
        playerName.textColor = UIColor.systemPink
        playerName.font = UIFont.systemFont(ofSize: 30.0)
        playerName.textAlignment = NSTextAlignment.center
        mainStack.addArrangedSubview(playerName)
        
        // create 2 buttons: -5, -1
        let minus5 = UIButton(type: .system)
        minus5.tag = playerNum
        minus5.configuration = .filled()
        minus5.setTitle("-\(lifeChunk)", for: .normal)
        minus5.addTarget(self, action: #selector(changeLives(_:)), for: .touchUpInside)
        
        let minus1 = UIButton(type: .system)
        minus1.tag = playerNum
        minus1.configuration = .filled()
        minus1.setTitle("-1", for: .normal)
        minus1.addTarget(self, action: #selector(changeLives(_:)), for: .touchUpInside)
        
        // create the life count label
        let lifeCount = UILabel()
        lifeCount.tag = playerNum
        lifeCount.text = "20"
        lifeCount.textColor = UIColor.systemPink
        lifeCount.font = UIFont.systemFont(ofSize: 25.0)
        labels.append(lifeCount)
        
        // create 2 buttons: +1, +5
        let plus1 = UIButton(type: .system)
        plus1.tag = playerNum
        plus1.configuration = .filled()
        plus1.setTitle("+1", for: .normal)
        plus1.addTarget(self, action: #selector(changeLives(_:)), for: .touchUpInside)
        
        let plus5 = UIButton(type: .system)
        plus5.tag = playerNum
        plus5.configuration = .filled()
        plus5.setTitle("+\(lifeChunk)", for: .normal)
        plus5.addTarget(self, action: #selector(changeLives(_:)), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [minus5, minus1, lifeCount, plus1, plus5])
        stackView.tag = currentNumPlayers
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        mainStack.addArrangedSubview(stackView)
    }
    
    @objc func checkButtons() {
        // base case: everything is enabled
        buttonAddPlayerReference.isEnabled = true
        buttonRemovePlayerReference.isEnabled = true
        textFieldLifeChunk.isEnabled = true
        
        if gameStarted == true {
            buttonAddPlayerReference.isEnabled = false
            buttonRemovePlayerReference.isEnabled = false
            textFieldLifeChunk.isEnabled = false
        } else if currentNumPlayers <= 2 {
            // disable remove players button
            buttonRemovePlayerReference.isEnabled = false
        } else if currentNumPlayers >= 8 {
            // disable add players button
            buttonAddPlayerReference.isEnabled = false
        }
    }
    
    @objc func changeLives(_ button:UIButton) {
        gameStarted = true
        checkButtons()
        let currentVal = Int(labels[button.tag - 1].text!) ?? 0
        
        // change the value of the button
        switch button.currentTitle! {
        case "-1":
            labels[button.tag - 1].text = String(currentVal - 1)
            history += "Player \(button.tag) lost a life.\n"
        case "-\(lifeChunk)":
            labels[button.tag - 1].text = String(currentVal - lifeChunk)
            history += "Player \(button.tag) lost \(lifeChunk) lives.\n"
        case "+1":
            labels[button.tag - 1].text = String(currentVal + 1)
            history += "Player \(button.tag) gained a life.\n"
        case "+\(lifeChunk)":
            labels[button.tag - 1].text = String(currentVal + lifeChunk)
            history += "Player \(button.tag) gained \(lifeChunk) lives.\n"
        default: labels[button.tag - 1].text = String(currentVal)
        }
        
        // somebody lost
        let newVal = labels[button.tag - 1].text
        if (Int(newVal!) ?? 0) <= 0 {
            showLoserAlert("Player \(button.tag)")
        }
    }
    
    @objc func showLoserAlert(_ loser : String) {
        gameStarted = false
        let alert = UIAlertController(title: "GAME OVER!", message: "\(loser) LOSES", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
        
        reset(4)
    }
    
    @objc func reset(_ numPlayers : Int) {
        // reset the buttons
        gameStarted = false
        checkButtons()
        
        // reset the history
        history = ""
        
        // removing all current players in the game
        for _ in labels {
            removePlayer()
        }
        
        // adding players 1 - 4 back to the game
        for _ in 1...numPlayers {
            addPlayer()
        }
        
    }
    
    @IBAction func buttonAddPlayer(_ sender: Any) {
        addPlayer()
    }
    
    @IBAction func buttonRemovePlayer(_ sender: Any) {
        removePlayer()
    }
    
    @IBAction func buttonReset(_ sender: Any) {
        reset(4)
    }
    
    @objc func removePlayer() {
        let toRemove1 = mainStack.arrangedSubviews[currentNumPlayers * 2 - 1]
        toRemove1.removeFromSuperview()
        let toRemove2 = mainStack.arrangedSubviews[(currentNumPlayers * 2) - 2]
        toRemove2.removeFromSuperview()
        
        currentNumPlayers -= 1
        labels.removeLast()
        
        checkButtons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowHistorySegue",
                let destinationVC = segue.destination as? HistoryViewController {
                    destinationVC.historyToDisplay = history
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // adding players 1 - 4 to the game
        addPlayer()
        addPlayer()
        addPlayer()
        addPlayer()
        
        setupToolbar()
    }
}


//
//  ViewController.swift
//  D20Roller
//
//  Created by Joshua Kersker on 1/21/20.
//  Copyright © 2020 Joshua Kersker. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet weak var criticalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func rollDice(){
        let rolledNumber = Int.random(in: 1...20)

        let imageName = "d\(rolledNumber)"
        diceImageView.image = UIImage(named: imageName)
        
        playSound(rollNumber: rolledNumber)
    }
    
    func playSound(rollNumber: Int){
        
        var fileName = ""
        
        if (rollNumber == 20){
            fileName = "zfanfare"
            criticalLabel.text = "HIT!!!"
            criticalLabel.isHidden = false
        } else if (rollNumber == 1){
            fileName = "failwah"
            criticalLabel.text = "Oof"
            criticalLabel.isHidden = false
        } else if (rollNumber == 7){
            let cruiserRoll = Int.random(in: 1...3)
            
            if (cruiserRoll == 1){
                let imageName = "d7cruiser"
                diceImageView.image = UIImage(named: imageName)
                
                fileName = "torpedo"
                criticalLabel.text = "I'm firing my lazer!"
                criticalLabel.isHidden = false
            } else {
                criticalLabel.isHidden = true
                fileName = "rolldice"
            }
        } else {
            criticalLabel.isHidden = true
            fileName = "rolldice"
        }
        let playSoundPlayer = Bundle.main.path(forResource: fileName, ofType: "mp3")!
        let url = URL(fileURLWithPath: playSoundPlayer)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch{
            
        }
    }
    
    @IBAction func rollDiceFromButton() {
        rollDice()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollDice()
    }
}


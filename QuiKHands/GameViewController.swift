//
//  GameViewController.swift
//  QuiKHands
//
//  Created by Aarish  Brohi on 5/14/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var TimeText: UILabel!
    
    @IBOutlet weak var ScoreText: UILabel!
    
    @IBOutlet weak var TapButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    //number of taps
    var tapInt = 0
    
    //starting timer of starting of 3
    var startInt  = 3
    
    //actual timer to start
    var startTime = Timer()
    
    //game of 10 seconds timer
    var gameInt = 10;
    
    //increments timer like startTime variable
    var gameTimer = Timer()
    
    //variable to hold highest score that can be used throughout view controllers
    var recordData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimeText.layer.masksToBounds = true
        TimeText.layer.cornerRadius = 10.0
        ScoreText.layer.masksToBounds = true
        ScoreText.layer.cornerRadius = 10.0
        TapButton.layer.cornerRadius = 10.0

        
        //when view loads up, make sure tapInt is set to 0
        tapInt = 0
        scoreLabel.text = String(tapInt)
        
        //allows for timer of button to always go back to 3
        startInt = 3
        
        gameInt = 10
        timerLabel.text = String(gameInt)
        
        
        //put timer on button, the .normal makes sure how we dont
        //want to change how we control and interact with the button
        TapButton.setTitle(String(startInt), for: .normal)
        
        //tapping doesnt do anything with timer 
        TapButton.isEnabled = false
        
        //kinda tricky,time interval set to 1 to go by one second each time
        //calling on it self each time
        //selector is to call on the function from class to file
        //user info -> no clue
        //repeats obviously
        startTime = Timer.scheduledTimer(timeInterval: 1, target: self,
                                         selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
        
        
        //allows to recordData to be saved and outputted
        //recorddata is then changed throughout in game()
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        recordData = value
    }
    
    @IBAction func Tap_Button(_ sender: Any) {
        //increases and labels score with each tap
        tapInt += 1
        scoreLabel.text = String(tapInt)
    }
    
    //start when button is pressed to start game
    @objc func startGameTimer(){
        startInt -= 1
        TapButton.setTitle(String(startInt), for: .normal)
        
        if(startInt == 0){
            //ends start time from running
            startTime.invalidate()
            
            TapButton.setTitle("QuikTaps", for: .normal)
            TapButton.isEnabled = true
            
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                             selector: #selector(GameViewController.game), userInfo: nil, repeats: true)
        }
    }
    
    
    @objc func game(){
        gameInt -= 1
        timerLabel.text = String(gameInt)
        
        if(gameInt == 0){
            gameTimer.invalidate()
            
            //first time play game, save key
            if(recordData == nil){
                let savedString = scoreLabel.text
                let userDefault = Foundation.UserDefaults.standard
                userDefault.set(savedString, forKey: "Record")
            }
            else{
                let score:Int? = Int(scoreLabel.text!)
                let record:Int? = Int(recordData)
                if(score! > record!){
                    let savedString = scoreLabel.text
                    let userDefault = Foundation.UserDefaults.standard
                    userDefault.set(savedString, forKey: "Record")
                }
            }
            
            
            
            
            TapButton.isEnabled = false
            Timer.scheduledTimer(timeInterval: 2, target: self,
                                 selector: #selector(GameViewController.end), userInfo: nil, repeats: false)
        }
    }
    
    @objc func end(){
        //vc = view controller
        //set vc as the view controller for the end view to be presented
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! EndViewController
        vc.modalPresentationStyle = .fullScreen
        
        //set up scoreData from end view class to output score
        //call on variable from another class
        vc.scoreData = scoreLabel.text
        self.present(vc, animated: false , completion: nil)
        
    }

}

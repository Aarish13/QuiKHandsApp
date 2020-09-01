//
//  ViewController.swift
//  QuiKHands
//
//  Created by Aarish  Brohi on 5/14/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HStext: UILabel!
    
    @IBOutlet weak var Score: UILabel!
    
    @IBOutlet weak var StartButton: UIButton!
    
    @IBOutlet weak var TitleGame: UILabel!
    
    //to make top with carrier, time, stuff return white on screen
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change corner radius to round for text
        TitleGame.layer.masksToBounds = true
        TitleGame.layer.cornerRadius = 10.0
        HStext.layer.masksToBounds = true
        HStext.layer.cornerRadius = 10.0
        
        //dont need masks to Bounds call for button to make corners round
        StartButton.layer.cornerRadius = 10.0
        

    }
    
    //called every time the view appears, not when loaded
    //view loaded also only triggers once when opened,
    //but viewwillappear does any amount of types
    //does the same from taking score from gameView to endView
    //but this way saves it thereby when application closes,
    //score still remains
    override func viewWillAppear(_ animated: Bool) {
        let userDefault = Foundation.UserDefaults.standard
        let value = userDefault.string(forKey: "Record")
        
        if(value == nil){
            Score.text = "0"
        }
        else{
            Score.text = value
        }

    }


}


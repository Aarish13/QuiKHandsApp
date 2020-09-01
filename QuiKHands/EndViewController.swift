//
//  EndViewController.swift
//  QuiKHands
//
//  Created by Aarish  Brohi on 5/15/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Social
import MessageUI

class EndViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var scoreText: UILabel!
    
    @IBOutlet weak var scoreNumber: UILabel!
    
    @IBOutlet weak var shareScreenText: UILabel!
    
    @IBOutlet weak var twitterButton: UIButton!
    
    @IBOutlet weak var emailButton: UIButton!
    
    @IBOutlet weak var smsButton: UIButton!
    
    @IBOutlet weak var restartButton: UIButton!
    
    
    //need to transfer data from gameView to endView
    var scoreData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreText.layer.masksToBounds = true
        scoreText.layer.cornerRadius = 10.0
        
        shareScreenText.layer.masksToBounds = true
        shareScreenText.layer.cornerRadius = 10.0
        
        
        twitterButton.layer.cornerRadius = 10.0
        emailButton.layer.cornerRadius = 10.0
        smsButton.layer.cornerRadius = 10.0
        restartButton.layer.cornerRadius = 10.0

        scoreNumber.text = scoreData
    }
    
    
    @IBAction func restartGame(_ sender: Any) {
        //cannot do segue from restart button to home screen
        //places game view on top of home view, then end view on top
        //stacking views on top over and over again not good
        //need to dismiss all view in function except home view
        //stacking views would cause memory issue and crash
        
        //dismiss from end view
        self.dismiss(animated: false, completion: nil)
        
        //cannot call self.dismiss again bc remember
        //self is from end view
        //need to dismiss in the presenting View Controller that had loaded
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        
    }
    

    
    @IBAction func shareTwitter(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)

            self.present(fbShare, animated: true, completion: nil)

        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    @IBAction func shareEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail(){
            let mail:MFMailComposeViewController = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(nil)
            mail.setSubject("I bet you can't beat me!")
            mail.setMessageBody("My final score was: \(scoreNumber.text!)", isHTML: false)
            self.present(mail, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Accounts", message: "Please login to an Email account to send.", preferredStyle: UIAlertController.Style.alert)
                       
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                       
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func shareSMS(_ sender: Any) {
        if(MFMessageComposeViewController.canSendText()){
            let message: MFMessageComposeViewController = MFMessageComposeViewController()
            message.messageComposeDelegate  = self
            message.recipients = nil
            message.body = "My final score was: \(scoreNumber.text!)"
            self.present(message, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "This device can not send SMS message.", preferredStyle: UIAlertController.Style.alert)
                       
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                       
            self.present(alert, animated: true, completion: nil)
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

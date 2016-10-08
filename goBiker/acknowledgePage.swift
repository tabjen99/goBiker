//
//  confirmationPage.swift
//  goBiker
//
//  Created by Mike on 08/10/2016.
//  Copyright © 2016 Mike. All rights reserved.
//


import UIKit

class acknowledgementPage: UIViewController   {
    // =========================================================================
    // MARK: - Variable Declaration
    @IBOutlet weak var ackDateTime: UILabel!
    @IBOutlet weak var Subtotal: UILabel!
    @IBOutlet weak var chargingFee: UILabel!
    
    // =========================================================================
    // MARK: - Override function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // =========================================================================
    // MARK: - Data processing
    
    @IBAction func gvRating(_ sender: AnyObject) {
        var answer:String
        
        switch sender.tag {
        case 1:
            answer = "Dissatisfied"
        case 2:
            answer = "Normal"
        case 3:
            answer = "Satisfied"
        case 4:
            answer = "In Love!"
        default:
            answer = ""
        }
        
        let alertController = UIAlertController(title: "Thankyou", message: "You have voted : \(answer)", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // =========================================================================
    // MARK: - Animate
    @IBAction func playAgain(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
    }

    func setupData(){
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        ackDateTime.text  = "\(appDelegate.transaction!.EstimateArrivalTime) \(appDelegate.transaction!.Date)"
        Subtotal.text    = "SubTotal : \(appDelegate.transaction!.Amount) (GST Inclusive)"
        chargingFee.text = appDelegate.transaction!.Amount
        navigationItem.hidesBackButton = true
    }
    
   
}

//
//  confirmationPage.swift
//  goBiker
//
//  Created by Mike on 08/10/2016.
//  Copyright © 2016 Mike. All rights reserved.
//


import UIKit

class confirmationPage: UIViewController   {
    // =========================================================================
    // MARK: - Variable Declaration
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var feeValue: UILabel!
    @IBOutlet weak var timeArrival: UILabel!
    
    
    // =========================================================================
    // MARK: - Override function
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize User Profile , This is for demo purpose.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        NSLog("Profile : \(appDelegate.userProfile?.UUID)")
        NSLog("biker : \(appDelegate.biker?.PlateNumberText)")
        NSLog("transaction : \(appDelegate.transaction?.EstimateArrivalTime)")
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =========================================================================
    // MARK: - Animate
    func setupData(){
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        driverName.text  = appDelegate.biker?.PlateNumberText
        feeValue.text    = appDelegate.transaction?.Amount
        timeArrival.text = appDelegate.transaction?.EstimateArrivalTime
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func goCompletePage(_ sender: AnyObject) {
        performSegue(withIdentifier: "page3", sender: nil)
    }
   }

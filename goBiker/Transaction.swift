//
//  Bike.swift
//  goBiker
//
//  Created by Mike Tan on 08/10/16.
//  Copyright © 2016 Mike Tan. All rights reserved.
//

import Foundation

class Transaction {
    /*
        Transaction Class storing information related to a bike calling transaction.
     */
    var TransactionID: String = ""
    var Date: String   = ""
    var EstimateArrivalTime: String = ""
    var EstimateDuration: String = ""
    var Amount: String = ""
    var Currency: String = ""
    
    init(TransactionID: String, Date: String , EstimateArrivalTime:String , EstimateDuration:String, Amount:String ,
         Currency:String) {
        self.TransactionID = TransactionID
        self.Date = Date
        self.EstimateArrivalTime = EstimateArrivalTime
        self.EstimateDuration = EstimateDuration
        self.Amount = Amount
        self.Currency = Currency
    }
    
}


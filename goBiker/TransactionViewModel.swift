//
//  TransactionModelView.swift
//  goBiker
//
//  Created by Mike Tan on 08/10/16.
//  Copyright © 2016 Mike Tan. All rights reserved.
//

import Foundation

class TransactionViewModel {
  fileprivate var transaction: Transaction

    var TransactionID: String {
        return transaction.TransactionID
    }
      
    var Date: String {
        return transaction.Date
    }
    
    var EstimateArrivalTime: String {
        return transaction.EstimateArrivalTime
    }
    
    var EstimateDuration: String {
        return transaction.EstimateDuration
    }
    
    var Amount: String {
        return "\(Currency) \(transaction.Amount)"
    }
    
    var Currency: String {
        return transaction.Currency
    }
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
}

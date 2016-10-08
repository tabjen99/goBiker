//
//  TransactionModelView.swift
//  goBiker
//
//  Created by Mike Tan on 08/10/16.
//  Copyright © 2016 Mike Tan. All rights reserved.
//

import Foundation

class ProfileViewModel {
  fileprivate var profile: Profile
    let currency:String = "RM"
    
    var UUID: String {
        return profile.UUID
    }
      
    var Balance: String {
        return "\(currency) \(profile.Balance)"
    }
    
    init(profile: Profile) {
        self.profile = profile
    }
}

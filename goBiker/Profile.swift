//
//  Profile.swift
//  goBiker
//
//  Created by Mike Tan on 08/10/16.
//  Copyright © 2016 Mike Tan. All rights reserved.
//

import Foundation

class Profile {
  var UUID: String = ""
  var Balance: Float = 0.0
   
    init(UUID: String, Balance: Float) {
        self.UUID = UUID
        self.Balance = Balance
    }
}

//
//  BikeModelView.swift
//  goBiker
//
//  Created by Mike Tan on 08/10/16.
//  Copyright © 2016 Mike Tan. All rights reserved.
//

import Foundation

class BikeViewModel {
  fileprivate var Bike: Bike
  
  var NameText: String {
    return Bike.Name
  }
  
  var PlateNumberText: String {
    return Bike.PlateNumber
  }
    
  init(Bike: Bike) {
        self.Bike = Bike
  }
}

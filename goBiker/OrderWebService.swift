//
//  webservice.swift
//  goBiker
//
//  Created by Mike on 08/10/2016.
//  Copyright © 2016 Mike. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 //Example data
 "TransactionID":"12345",
 "Date ":"2016-10-08",
 "EstimateArrivalTime":"16:00:00",
 "EstimateDuration":"30 mins",
 "Amount":"30.00",
 "Currency":"MYR",
 "Biker":{
 "Name":"John Dolly",
 "PlateNumber":"Ak 123"
 }
 */

struct Webservice: Mappable {
    var TransactionID        = ""
    var Date                 = ""
    var EstimateArrivalTime  = ""
    var EstimateDuration     = ""
    var Amount               = ""
    var Currency             = ""
    var Biker                = [BikerDetail]()
    
    
    init?(map: Map) {
        // Validate your JSON here: check for required properties, etc
    }
    
    mutating func mapping(map: Map) {
        TransactionID       <- map["TransactionID"]
        Date                <- map["Date"]
        EstimateArrivalTime <- map["EstimateArrivalTime"]
        EstimateDuration    <- map["EstimateDuration"]
        Amount              <- map["Amount"]
        Currency            <- map["Currency"]
        Biker               <- map["Biker"]
    }
}

struct BikerDetail: Mappable {
    var Name = ""
    var PlateNumber = ""
    
    
    init?(map: Map) {
        // Validate your JSON here: check for required properties, etc
    }
    
    mutating func mapping(map: Map) {
        Name            <- map["Name"]
        PlateNumber     <- map["PlateNumber"]
        
    }
}

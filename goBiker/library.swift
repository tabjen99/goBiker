//
//  library.swift
//  goBiker
//
//  Created by Mike on 09/10/2016.
//  Copyright © 2016 Mike. All rights reserved.
//

import Foundation
import Alamofire

class library: UIViewController   {
    
enum webservice: Error {
    case createOrder
    case getProfile
}
var delegate: ViewControllerDelegate?

open func callingWebService (_ action:webservice)
{
    var parameters: Parameters = ["action": "unknow"]
    switch action{
        case webservice.createOrder:
            parameters = ["action": "createOrder"]
        break
        case webservice.getProfile:
            parameters = ["action": "getProfile"]
        break
    }
    
    // http://www.mocky.io/v2/57f921880f0000b6145a7ce3 - invalid format
    // http://www.mocky.io/v2/57f915490f000074135a7ce1 - correct
    Alamofire.request("http://www.mocky.io/v2/57f915490f000074135a7ce1",parameters: parameters).validate().responseString { response in
        switch response.result {
        case .success:
           self.delegate!.successRespone(data:response.result.value!)
        case .failure( _):
            self.delegate!.failedRespone(error:response.result.value!, retry: true)
            
        }
    }
}
    
}

//
//  UtilityService.swift
//  VehicleSimulator
//
//  Created by Asha Balasubramaniam on 8/27/15.
//  Copyright (c) 2015 Asha Balasubramaniam. All rights reserved.
//

import Foundation
import IJReachability

class UtilityService {
  
  class var sharedInstance: UtilityService {
    
    struct Singleton {
      static let instance = UtilityService()
    }
    
    return Singleton.instance
  }
  
  func isConnectedToNetwork() -> Bool {
    return IJReachability.isConnectedToNetwork()
  }
}
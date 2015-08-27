//
//  LocationService.swift
//  VehicleSimulator
//
//  Created by Asha Balasubramaniam on 8/27/15.
//  Copyright (c) 2015 Asha Balasubramaniam. All rights reserved.
//

import Foundation

class LocationService {
  
  let utilityService = UtilityService.sharedInstance
  var unsavedLocations: [LocationModel] = []
  
  class var sharedInstance: LocationService {
    
    struct Singleton {
      static let instance = LocationService()
    }
    
    return Singleton.instance
  }
  
  func saveLocation(location: LocationModel) {
    if utilityService.isConnectedToNetwork() {
      if unsavedLocations.count > 0 {
        println("Save the cached locations first")
        for unsavedLoc in unsavedLocations {
          unsavedLoc.save()
        }
        unsavedLocations.removeAll(keepCapacity: false)
      }
      location.save()
    } else {
      println("No connectivity detected so caching the locations")
      unsavedLocations.append(location)
    }
  }
}
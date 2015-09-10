//
//  LocationModel.swift
//  VehicleSimulator
//
//  Created by Asha Balasubramaniam on 8/27/15.
//  Copyright (c) 2015 Asha Balasubramaniam. All rights reserved.
//

import Foundation
import CoreLocation
import Parse

class LocationModel {
  var coordinate: PFGeoPoint
  var busId: String
  var id:String!
  let utilityService = UtilityService.sharedInstance
  
  init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, busExternalId: String) {
    coordinate = PFGeoPoint(latitude: latitude, longitude: longitude)
    busId = busExternalId
  }
  
  func save() {
    var query = PFQuery(className: "Bus")
    query.whereKey("ExternalId", equalTo:busId)
    
    query.findObjectsInBackgroundWithBlock({ (results:[AnyObject]?, error: NSError?) -> Void in
      if let results = results {
        var bus: PFObject = results[0] as! PFObject
        var location = PFObject(className:"BusLocation")
        location["coordinate"] = self.coordinate
        location["bus"] = PFObject(withoutDataWithClassName: "Bus", objectId: bus.objectId)
        
        var currentUser = PFUser.currentUser()
        location.ACL = PFACL(user: currentUser!)
        
        location.saveInBackgroundWithBlock({ (success:Bool, error: NSError?) -> Void in
          if success {
            println("Location saved successfully")
            self.id = location.objectId
            
            bus["lastKnownLocation"] = location
            bus.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
              if success {
                println("Latest location of bus has been updated")
              } else {
                println("Error updating bus's latest location")
              }
            })
            
          } else {
            println(error?.description)
          }
        })
      }
    })
  }
}
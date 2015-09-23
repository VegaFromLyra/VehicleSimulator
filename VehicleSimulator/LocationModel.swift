//
//  LocationModel.swift
//  VehicleSimulator
//
//  Created by Asha Balasubramaniam on 8/27/15.
//  Copyright (c) 2015 Asha Balasubramaniam. All rights reserved.
//

import CoreLocation
import Parse

class LocationModel {
  var coordinate: PFGeoPoint
  var busNumber: String
  var id:String!
  let utilityService = UtilityService.sharedInstance
  
  init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, number: String) {
    coordinate = PFGeoPoint(latitude: latitude, longitude: longitude)
    busNumber = number
  }
  
  func save() {
    let query = PFQuery(className: "Bus")
    query.whereKey("busNumber", equalTo:busNumber)
    
    query.findObjectsInBackgroundWithBlock { (buses: [PFObject]?, error: NSError?) -> Void in
      if let buses = buses {
        let bus: PFObject = buses[0]
        let location = PFObject(className: "BusLocation")
        location["coordinate"] = self.coordinate
        location["bus"] = PFObject(withoutDataWithClassName: "Bus", objectId: bus.objectId)
        
        let currentUser = PFUser.currentUser()
        location.ACL = PFACL(user: currentUser!)
        
        location.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
          if success {
            print("Location saved successfully")
            self.id = location.objectId
            bus["lastKnownLocation"] = location
            
            bus.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
              if success {
                print("Latest location has been updated")
              } else {
                print("Error updating latest location")
              }
            })
          } else {
            print(error?.description)
          }
        })
      }
    }
  }
}
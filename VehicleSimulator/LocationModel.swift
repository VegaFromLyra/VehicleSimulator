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
  var reportedTime: NSDate
  var busOperatorName: String
  let utilityService = UtilityService.sharedInstance
  var locationParameters = [String: AnyObject]()
  
  init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, number: String, busOperatorName: String, reportedTime: NSDate) {
    self.coordinate = PFGeoPoint(latitude: latitude, longitude: longitude)
    self.busNumber = number
    self.busOperatorName = busOperatorName
    self.reportedTime = reportedTime
  
    locationParameters.updateValue(self.coordinate, forKey: "coordinate")
    locationParameters.updateValue(self.busNumber, forKey: "busNumber")
    locationParameters.updateValue(self.busOperatorName, forKey: "busOperatorName")
    locationParameters.updateValue(self.reportedTime, forKey: "reportedTime")
  }
  
  func save() {
    PFCloud.callFunctionInBackground("reportLocation", withParameters: locationParameters) {
      (response: AnyObject?, error: NSError?) -> Void in
      if error == nil {
        print("Location reported")
      } else {
        print(error?.description)
      }
    }
  }
}
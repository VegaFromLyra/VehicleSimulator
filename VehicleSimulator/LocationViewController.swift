//
//  LocationViewController.swift
//  VehicleSimulator
//
//  Created by Asha Balasubramaniam on 8/27/15.
//  Copyright (c) 2015 Asha Balasubramaniam. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
  
  @IBOutlet weak var latitudeLabel: UILabel!
  @IBOutlet weak var longitudeLabel: UILabel!
  
  let locationManager: CLLocationManager =  CLLocationManager()
  let busOperatorId = "BusOperator1"
  let busId = "actionmanBus"
  let locationService = LocationService.sharedInstance
  
  
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    locationManager.delegate = self
    locationManager.requestAlwaysAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.distanceFilter = 25 // TODO; Tune this value based on data
  }
  
  @IBAction func startUpdatingLocation(sender: AnyObject) {
    locationManager.startUpdatingLocation()
    startButton.userInteractionEnabled = false
    stopButton.userInteractionEnabled = true
  }
  
  @IBAction func stopUpdatingLocation(sender: AnyObject) {
    locationManager.stopUpdatingLocation()
    startButton.userInteractionEnabled = true
    stopButton.userInteractionEnabled = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}

extension LocationViewController: CLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    var currentLocation = locations.first as? CLLocation
    if let currentLocation = currentLocation {
      latitudeLabel.text = String(format:"%f", currentLocation.coordinate.latitude)
      longitudeLabel.text = String(format:"%f", currentLocation.coordinate.longitude)
      var location = LocationModel(latitude: currentLocation.coordinate.latitude,
        longitude: currentLocation.coordinate.longitude,
        busExternalId: busId)
      locationService.saveLocation(location)
    } else {
      latitudeLabel.text = ""
      longitudeLabel.text = ""
    }
  }
}

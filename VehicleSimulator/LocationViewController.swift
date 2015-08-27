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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    locationManager.delegate = self
    locationManager.requestAlwaysAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
  }
  
  @IBAction func stopUpdatingLocation(sender: AnyObject) {
    locationManager.stopUpdatingLocation()
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
    } else {
      latitudeLabel.text = ""
      longitudeLabel.text = ""
    }
  }
}

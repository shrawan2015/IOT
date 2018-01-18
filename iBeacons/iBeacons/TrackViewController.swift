//
//  TrackViewController.swift
//  iBeacons
//
//  Created by ShrawanKumar Sharma on 17/01/18.
//  Copyright © 2018 iBeacons. All rights reserved.
//

import UIKit
import CoreLocation

class TrackViewController: UIViewController ,CLLocationManagerDelegate {
    
    @IBOutlet weak var iBeaconFoundLabel: UILabel!
    @IBOutlet weak var proximityUUIDLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    var locationManager : CLLocationManager!
     func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion){
        
        if beacons.count > 0{
            let beacon = beacons.last

            print("bracon", beacons)
            iBeaconFoundLabel.text = "Yes"
            proximityUUIDLabel.text = beacon?.proximityUUID.uuidString
            majorLabel.text = beacon?.major.stringValue
            minorLabel.text = beacon?.minor.stringValue
            accuracyLabel.text = String(describing: beacon?.accuracy)
            if beacon?.proximity == CLProximity.unknown {
                distanceLabel.text = "Unknown Proximity"
            } else if beacon?.proximity == CLProximity.immediate {
                distanceLabel.text = "Immediate Proximity"
            } else if beacon?.proximity == CLProximity.near {
                distanceLabel.text = "Near Proximity"
            } else if beacon?.proximity == CLProximity.far {
                distanceLabel.text = "Far Proximity"
            }
          //  rssiLabel.text = String(describing: beacon?.rssi)
        }
    }

    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("range in the beacons")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        startScanningForBeaconRegion(beaconRegion: getBeaconRegion())
    }
    
    func startScanningForBeaconRegion(beaconRegion: CLBeaconRegion) {
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func getBeaconRegion() -> CLBeaconRegion {
        let beaconRegion = CLBeaconRegion.init(proximityUUID: UUID.init(uuidString: "E06F95E4-FCFC-42C6-B4F8-F6BAE87EA1A0")!,identifier: "com.devfright.myRegion")
        return beaconRegion
    }

}

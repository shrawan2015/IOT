//
//  TransmitViewController.swift
//  iBeacons
//
//  Created by ShrawanKumar Sharma on 17/01/18.
//  Copyright © 2018 iBeacons. All rights reserved.
//

import UIKit

import CoreLocation
import CoreBluetooth

class TransmitViewController: UIViewController,CBPeripheralManagerDelegate {
    
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!
    @IBOutlet weak var identityLabel: UILabel!
    
    var beaconRegion : CLBeaconRegion!
    var beaconPeripheralData : NSDictionary! /// to store the data for the storage
    var peripheralManager : CBPeripheralManager!  // Manages the peripheral deices
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        //
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("peripheral",peripheral)
        
        if (peripheral.state == .poweredOn) {
            peripheralManager .startAdvertising(beaconPeripheralData as? [String : Any])
            print("Powered On")
        } else {
            peripheralManager .stopAdvertising()
            print("Not Powered On, or some other error")
        }
        
    }
    
    func initBeaconRegion() {
        beaconRegion = CLBeaconRegion.init(proximityUUID: UUID.init(uuidString: "E06F95E4-FCFC-42C6-B4F8-F6BAE87EA1A0")!,
                                           major: 1233,
                                           minor: 45,
                                           identifier: "com.devfright.myRegion")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initBeaconRegion()
        setLabels()
        // Do any additional setup after loading the view.
    }

    
    func setLabels() {
        uuidLabel.text = beaconRegion.proximityUUID.uuidString
        majorLabel.text = beaconRegion.major?.stringValue
        minorLabel.text = beaconRegion.minor?.stringValue
        identityLabel.text = beaconRegion.identifier
    }
    
    
    @IBAction func transmitDataForBeacons(_ sender: UIButton) {
        beaconPeripheralData = beaconRegion.peripheralData(withMeasuredPower: nil)
        peripheralManager  = CBPeripheralManager(delegate: self, queue: nil)
    }


}

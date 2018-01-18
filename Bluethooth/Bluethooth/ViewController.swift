//
//  ViewController.swift
//  Bluethooth
//
//  Created by ShrawanKumar Sharma on 18/01/18.
//  Copyright © 2018 IOT. All rights reserved.
//
import UIKit
import CoreBluetooth

class ViewController: UIViewController,CBCentralManagerDelegate {
    var centralManager: CBCentralManager!
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            print("central.state is .poweredOn")
        }
    }
    
    var heartRatePeripheral: CBPeripheral!

    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //Now we need to scan for the peripheral devices.
    //In Bluetooth-speak, finding a peripheral is known as discovering, so the delegate method you’ll want to use will have the word discover in it.
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("peripheral device",peripheral)
        
        heartRatePeripheral  = peripheral
        heartRatePeripheral.delegate = self

        centralManager.stopScan()
        centralManager.connect(heartRatePeripheral, options: nil)
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected to peripheral devices",peripheral)
     
        //do not use this here
        //heartRatePeripheral.discoverServices(nil)
        
    }
}

extension ViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("services",peripheral)
        guard let services = peripheral.services else { return }
        for service in services {
            print(service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            print(characteristic)
        }
    }
}

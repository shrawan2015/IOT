//
//  ViewController.swift
//  IOT
//
//  Created by ShrawanKumar Sharma on 18/01/18.
//  Copyright © 2018 IOT. All rights reserved.
//

import UIKit
import CocoaMQTT

class ViewController: UIViewController {
    @IBOutlet weak var switchButton: UISwitch!

    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "192.168.0.X", port: 1883)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func DisconnectIOTDevice(_ sender: UIButton) {
        mqttClient.disconnect()
    }
    
    @IBAction func connectIOTDevice(_ sender: UIButton) {
       mqttClient.connect()
    }
    
    @IBAction func swithcButtonAction(_ sender: UISwitch) {
        
        ////rpi/gpio
        if sender.isOn {
            mqttClient.publish("rpi/gpio", withString: "on")
        }
        else {
            mqttClient.publish("rpi/gpio", withString: "off")
        }
    }
    
    
}


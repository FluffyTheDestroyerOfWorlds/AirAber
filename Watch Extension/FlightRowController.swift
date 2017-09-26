//
//  FlightRowController.swift
//  AirAber
//
//  Created by Main Account on 10/1/15.
//  Copyright © 2015 Mic Pringle. All rights reserved.
//

import WatchKit

class FlightRowController: NSObject {

  @IBOutlet var separator: WKInterfaceSeparator!
  @IBOutlet var originLabel: WKInterfaceLabel!
  @IBOutlet var destinationLabel: WKInterfaceLabel!
  @IBOutlet var flightNumberLabel: WKInterfaceLabel!
  @IBOutlet var statusLabel: WKInterfaceLabel!
  @IBOutlet var planeImage: WKInterfaceImage!
  
  // 1
  var flight: Flight? {
    // 2
    didSet {
      // 3
      if let flight = flight {
        // 4
        originLabel.setText(flight.origin)
        destinationLabel.setText(flight.destination)
        flightNumberLabel.setText(flight.number)
        // 5
        if flight.onSchedule {
          statusLabel.setText("On Time")
        } else {
          statusLabel.setText("Delayed")
          statusLabel.setTextColor(UIColor.red)
        }
      }
    }
  }
  
  func updateForCheckIn() {
    let color = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
    planeImage.setTintColor(color)
    separator.setColor(color)
  }

}

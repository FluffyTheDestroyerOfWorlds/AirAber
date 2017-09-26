//
//  ScheduleInterfaceController.swift
//  AirAber
//
//  Created by Main Account on 10/1/15.
//  Copyright © 2015 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {
  
  @IBOutlet var flightsTable: WKInterfaceTable!
  var flights = Flight.allFlights()
  var selectedIndex = 0
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
    
    for index in 0..<flightsTable.numberOfRows {
      if let controller = flightsTable.rowController(at: index) as? FlightRowController {
        controller.flight = flights[index]
      }
    }
  }
  
  override func didAppear() {
    super.didAppear()
    // 1
    if flights[selectedIndex].checkedIn, let controller = flightsTable.rowController(at: selectedIndex) as? FlightRowController {
      // 2
      animate(withDuration: 0.35, animations: { () -> Void in
        // 3
        controller.updateForCheckIn()
      })
    }
  }
  
  override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    let flight = flights[rowIndex]
    let controllers = flight.checkedIn ? ["Flight", "BoardingPass"] : ["Flight", "CheckIn"]
    selectedIndex = rowIndex
    presentController(withNames: controllers, contexts:[flight, flight])
  }
  
}

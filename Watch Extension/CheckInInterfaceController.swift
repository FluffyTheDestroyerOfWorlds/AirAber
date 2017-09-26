//
//  CheckInInterfaceController.swift
//  AirAber
//
//  Created by Main Account on 10/1/15.
//  Copyright © 2015 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class CheckInInterfaceController: WKInterfaceController {

  @IBOutlet var backgroundGroup: WKInterfaceGroup!
  @IBOutlet var originLabel: WKInterfaceLabel!
  @IBOutlet var destinationLabel: WKInterfaceLabel!
  
  var flight: Flight? {
    didSet {
      if let flight = flight {
        originLabel.setText(flight.origin)
        destinationLabel.setText(flight.destination)
      }
    }
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    if let flight = context as? Flight { self.flight = flight }
  }
  
  @IBAction func checkInButtonTapped() {
    // 1
    let duration = 0.35
    let delay = DispatchTime.now() + Double(Int64((duration + 0.15) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    // 2
    backgroundGroup.setBackgroundImageNamed("Progress")
    // 3
    backgroundGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 10), duration: duration, repeatCount: 1)
    // 4
    DispatchQueue.main.asyncAfter(deadline: delay) { () -> Void in
      // 5
      self.flight?.checkedIn = true
      self.dismiss()
    }
  }

}

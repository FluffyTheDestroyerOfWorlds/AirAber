//
//  BoardingPassInterfaceController.swift
//  AirAber
//
//  Created by Main Account on 10/2/15.
//  Copyright © 2015 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class BoardingPassInterfaceController: WKInterfaceController {
  
  @IBOutlet var originLabel: WKInterfaceLabel!
  @IBOutlet var destinationLabel: WKInterfaceLabel!
  @IBOutlet var boardingPassImage: WKInterfaceImage!

  var flight: Flight? {
    didSet {
      if let flight = flight {
        originLabel.setText(flight.origin)
        destinationLabel.setText(flight.destination)
        
        if let _ = flight.boardingPass {
          showBoardingPass()
        }
      }
    }
  }
  
  var session: WCSession? {
    didSet {
      if let session = session {
        session.delegate = self
        session.activate()
      }
    }
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    if let flight = context as? Flight { self.flight = flight }
  }
  
  override func didAppear() {
    super.didAppear()
    // 1
    if let flight = flight, flight.boardingPass == nil && WCSession.isSupported() {
      // 2
      session = WCSession.default()
      // 3
      session!.sendMessage(["reference": flight.reference], replyHandler: { (response) -> Void in
        // 4
        if let boardingPassData = response["boardingPassData"] as? Data, let boardingPass = UIImage(data: boardingPassData) {
          // 5
          flight.boardingPass = boardingPass
          DispatchQueue.main.async(execute: { () -> Void in
            self.showBoardingPass()
          })
        }
      }, errorHandler: { (error) -> Void in
        // 6
        print(error)
      })
    }
  }
  
  fileprivate func showBoardingPass() {
    boardingPassImage.stopAnimating()
    boardingPassImage.setWidth(120)
    boardingPassImage.setHeight(120)
    boardingPassImage.setImage(flight?.boardingPass)
  }
  
}

extension BoardingPassInterfaceController: WCSessionDelegate {
	/** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
	@available(watchOS 2.2, *)
	func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
	
	}

}
	

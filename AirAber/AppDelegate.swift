//
//  AppDelegate.swift
//  AirAber
//
//  Created by Mic Pringle on 05/08/2015.
//  Copyright © 2015 Mic Pringle. All rights reserved.
//

import UIKit
import WatchConnectivity


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  var session: WCSession? {
    didSet {
      if let session = session {
        session.delegate = self
        session.activate()
      }
    }
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
  
    if WCSession.isSupported() {
      session = WCSession.default()
    }
    
    return true
  }

}

extension AppDelegate: WCSessionDelegate {
	/** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
	@available(iOS 9.3, *)
	func sessionDidDeactivate(_ session: WCSession) {
		
	}

	/** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
	@available(iOS 9.3, *)
	func sessionDidBecomeInactive(_ session: WCSession) {
	
	}

	/** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
	@available(iOS 9.3, *)
	func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
	
	}

 
  func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
    if let reference = message["reference"] as? String, let boardingPass = QRCode(reference) {
      replyHandler(["boardingPassData": boardingPass.PNGData])
    }
  }

}

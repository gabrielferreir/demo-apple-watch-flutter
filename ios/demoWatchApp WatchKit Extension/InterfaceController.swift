//
//  InterfaceController.swift
//  demoWatchApp WatchKit Extension
//
//  Created by Gabriel on 11/05/22.
//

import WatchKit
import Foundation
import WatchConnectivity



class InterfaceController: WKInterfaceController, WCSessionDelegate {

    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    @IBAction func increaseBt() {
        self.labelValue += 1
        self.label.setText(String(self.labelValue))
    }
    
    @IBAction func decreaseBt() {
        self.labelValue -= 1
        self.label.setText(String(self.labelValue))
    }
    
    @IBOutlet var label: WKInterfaceLabel!
    var labelValue: Int = 0;
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if(WCSession.isSupported()){
         let session = WCSession.default;
         session.delegate = self;
         session.activate();
        }
        
        label.setText("0")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        var counter = message["counter"] as! String
        self.label.setText(counter)
        self.labelValue = Int(counter) ?? 0;
    }

}

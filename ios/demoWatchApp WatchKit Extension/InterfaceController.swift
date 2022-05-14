//
//  InterfaceController.swift
//  demoWatchApp WatchKit Extension
//
//  Created by Gabriel on 11/05/22.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    @IBAction func increaseBt() {
            self.labelValue += 1
            self.label.setText(String(self.labelValue))
            WatchConnectivityManager.shared.send(String(self.labelValue))
    }
    
    @IBAction func decreaseBt() {
        self.labelValue -= 1
        self.label.setText(String(self.labelValue))
        WatchConnectivityManager.shared.send(String(self.labelValue))
    }
    
    @objc func updateLabel(_ notification: Notification) {
        self.labelValue = Int(notification.object as! String) ?? 0;
        self.label.setText(String(labelValue))
    }
    
    @IBOutlet var label: WKInterfaceLabel!
    var labelValue: Int = 0;
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        WatchConnectivityManager.shared.send(String(labelValue))
        self.label.setText(String(labelValue))
        WatchConnectivityManager.shared.center.addObserver(self,
                                                            selector: #selector(updateLabel),
                                                            name: .message,
                                                            object: nil
                                                        )
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

import UIKit
import Flutter

@available(iOS 13, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate{
    
  var channel: FlutterMethodChannel?;
    
    @objc func sendMessageToFlutter(_ notification: Notification) {
        channel?.invokeMethod("new_string", arguments: notification.object)
    }

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      channel = FlutterMethodChannel(name: "myWatchChannel", binaryMessenger: controller.binaryMessenger)
      
      WatchConnectivityManager.shared.center.addObserver(self,
                                                          selector: #selector(sendMessageToFlutter),
                                                          name: .message,
                                                          object: nil
                                                      )
   
      
    channel!.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if(call.method == "sendStringToNative"){
          WatchConnectivityManager.shared.send(call.arguments as! String)
      }
    })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

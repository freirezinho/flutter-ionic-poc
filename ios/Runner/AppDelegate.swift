import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var mainCoordinator: NativeCoordinator?
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let firstIonicChannel = FlutterMethodChannel(name: "com.bundle/navToIonic", binaryMessenger: flutterViewController.binaryMessenger)
    
    firstIonicChannel.setMethodCallHandler { (call, result) in
        guard call.method == "navToIonic" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self.mainCoordinator?.start()
    }
    
    let navigationController = UINavigationController(rootViewController: flutterViewController)
    navigationController.isNavigationBarHidden = true
    window?.rootViewController = navigationController
    mainCoordinator = NativeCoordinator(navigationController: navigationController)
    window?.makeKeyAndVisible()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

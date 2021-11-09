import UIKit
import Flutter
import Cordova

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var mainCoordinator: NativeCoordinator?
    
    override init() {
        let cookieStorage = HTTPCookieStorage.shared
        cookieStorage.cookieAcceptPolicy = .always
        let cacheSizeMemory = 8 * 1024 * 1024
        let cacheSizeDisk = 32 * 1024 * 1024
        let sharedCache = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: "nsurlcache")
        URLCache.shared = sharedCache
        super.init()
    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let firstIonicChannel = FlutterMethodChannel(name: "com.ionicFlutterPoc/navToIonic", binaryMessenger: flutterViewController.binaryMessenger)
    
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
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var openURLData: [String: Any] = [:]
        openURLData["url"] = url
        if ((options[.annotation]) != nil) {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "CDVPluginHandleOpenURLNotification"), object: url))
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "CDVPluginHandleOpenURLWithAppSourceAndAnnotationNotification"), object: openURLData))
            return true
        }
        return false
    }
    override func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        URLCache.shared.removeAllCachedResponses()
    }
}

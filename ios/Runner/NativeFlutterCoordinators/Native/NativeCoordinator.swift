//
//  NativeCoordinator.swift
//  Runner
//
//  Created by Saulo on 04/11/21.
//

import Foundation
import UIKit

class NativeCoordinator: BaseCoordinator{
 weak var navigationController: UINavigationController?
 
 init(navigationController: UINavigationController) {
   super.init()
   self.navigationController = navigationController
 }
 
 override func start() {
  super.start()
  navigateToIonicViewController() }
 }
protocol IonicToNativeCoordinatorDelegate: AnyObject {
 func navigateToFlutterViewController()
}
protocol FlutterToNativeCoordinatorDelegate: AnyObject {
 func navigateToIonicViewController()
}

extension NativeCoordinator: IonicToNativeCoordinatorDelegate{
    func navigateToFlutterViewController(){
        let coordinator = FlutterCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        self.add(coordinator)
        coordinator.start()
    }
}

extension NativeCoordinator: FlutterToNativeCoordinatorDelegate{
    func navigateToIonicViewController(){
        let coordinator = IonicCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        self.add(coordinator)
        coordinator.start()
    }
}

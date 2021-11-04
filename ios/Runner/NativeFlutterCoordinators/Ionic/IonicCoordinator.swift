//
//  IonicCoordinator.swift
//  Runner
//
//  Created by Saulo on 04/11/21.
//

import Foundation
import UIKit

final class IonicCoordinator: BaseCoordinator {
    weak var navigationController: UINavigationController?
    weak var delegate: IonicToNativeCoordinatorDelegate?
    
    override func start() {
        super.start()
        let ionicViewController = IonicViewController()
        ionicViewController.coordinatorDelegate = self
        navigationController?.pushViewController(ionicViewController, animated: false)
    }
    
    init(navigationController: UINavigationController?) {
        super.init()
        self.navigationController = navigationController
    }
}

protocol IonicCoordinatorDelegate {
    func navigateToFlutter()
}

extension IonicCoordinator: IonicCoordinatorDelegate {
    func navigateToFlutter() {
        self.delegate?.navigateToFlutterViewController()
    }
}

//import UIKit
//class IonicViewController: UIViewController {
//  var coordinatorDelegate: IonicCoordinatorDelegate?
//  override func viewDidLoad() {
//     super.viewDidLoad()
//  }
//  @IBAction func goToFlutter(_ sender: Any){
//    coordinatorDelegate?.navigateToFlutter()
//  }
//}

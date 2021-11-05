//
//  IonicFirstAppCoordinator.swift
//  Runner
//
//  Created by Saulo on 04/11/21.
//

import Foundation
import UIKit

final class IonicFirstAppCoordinator: BaseCoordinator {
    weak var navigationController: UINavigationController?
    weak var delegate: IonicToNativeCoordinatorDelegate?
    
    override func start() {
        super.start()
        let ionicViewController = IonicFirstAppViewController()
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

extension IonicFirstAppCoordinator: IonicCoordinatorDelegate {
    func navigateToFlutter() {
        self.delegate?.navigateToFlutterViewController()
    }
}

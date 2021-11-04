//
//  IonicViewController.swift
//  Runner
//
//  Created by Saulo Santos Freire on 04/11/21.
//

import Foundation
import UIKit
import ionicAppOne

class IonicViewController:MainViewController {
    var coordinatorDelegate: IonicCoordinatorDelegate?
    
    func goToFlutter(_ sender: Any){
        coordinatorDelegate?.navigateToFlutter()
    }
}

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
    
    override func configFilePath() -> String? {
        var path = self.configFile ?? "config.xml";
        if (!NSString(string: path).isAbsolutePath) {
            let podBundle = Bundle(for: MainViewController.self)
            let resourceURL = podBundle.resourceURL?.appendingPathComponent("ionicAppOne.bundle")
            let resourceBundle = Bundle(url: resourceURL!)
            
            guard let absolutePath = resourceBundle!.path(forResource: path, ofType: nil) else {
                assertionFailure("\(path) not found in the pod bundle!")
                return nil
            }
            path = absolutePath
        }
        
        if(!FileManager.default.fileExists(atPath: path)) {
            assertionFailure("\(path) does not exist. Please run cordova-ios/bin/cordova_plist_to_config_xml path/to/project.")
            return nil
        }
        
        return path
    }
}

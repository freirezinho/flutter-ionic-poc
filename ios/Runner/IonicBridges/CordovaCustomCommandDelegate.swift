//
//  CordovaCustomCommandDelegate.swift
//  Runner
//
//  Created by Saulo Santos Freire on 05/11/21.
//

import Foundation
import Cordova

class CDVCustomCommandDelegate: CDVCommandDelegateImpl {
    
    var classInBundle: AnyClass?
    
    override func path(forResource resourcepath: String!) -> String! {
        let classForBundle: AnyClass? = classInBundle
                let bundleFullName: String = "ionicAppOne.bundle"
                let folderName = viewController?.wwwFolderName
                
                let bundleForClass: Bundle = Bundle(for: classForBundle!.self)
                let resourceURL = bundleForClass.resourceURL?.appendingPathComponent(bundleFullName)
                let resourceBundle = Bundle(url: resourceURL!)
                var directoryParts: [String] = resourcepath.components(separatedBy: "/")
                let filename = directoryParts.last

                directoryParts.removeLast()
                let directoryPartsJoined = directoryParts.joined(separator: "/")
                var directoryString = folderName
                if (directoryPartsJoined.count > 0) {
                    directoryString = "\(folderName!)/\(directoryParts.joined(separator: "/"))"
                }
                return resourceBundle?.path(forResource: filename, ofType: "", inDirectory: directoryString)
    }
}
